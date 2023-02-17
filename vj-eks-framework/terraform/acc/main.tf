provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.10.0"
  name = "my-vpc"
  cidr = var.vpc_cidr_block
  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = split(",", var.app_subnets)
  public_subnets = split(",", var.db_subnets)
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "16.0.0"
  cluster_name = "my-cluster"
  subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  fargate_profiles = [
    {
      name = "my-fargate-profile"
      selectors = [
        {
          namespace = "default"
          labels = {
            "type" = "app"
          }
        }
      ]
    }
  ]
  vpc_config = {
    security_group_ids = [module.eks_cluster_sg.security_group_id]
  }
  manage_aws_auth = false
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  providers = {
    aws = aws.default
  }
}

module "rds" {
  source = "terraform-aws-modules/rds/aws"
  version = "3.0.0"
  name = "my-rds"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = var.rds_instance_class
  username = var.rds_username
  password = var.rds_password
  subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  skip_final_snapshot = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  name = "alb"
  vpc_id = module.vpc.vpc_id
  ingress_with_cidr = [
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks_cluster_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  name = "eks-cluster"
  vpc_id = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow communication from ALB"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Allow internal communication"
      source_security_group_id = module.eks_cluster_sg.security_group_id
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  name = "rds"
  vpc_id = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Allow access from app security group"
      source_security_group_id = module.app_sg.security_group_id
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  name = "app"
  vpc_id = module.vpc.vpc_id
  ingress_with_cidr = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  ]
  egress_with_cidr = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "icmp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "udp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create CloudWatch log group for VPC flow logs
resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name              = "/aws/vpc/flow-logs/${var.vpc_id}"
  retention_in_days = 30
}

# Create CloudWatch log stream for VPC flow logs
resource "aws_cloudwatch_log_stream" "vpc_log_stream" {
  name           = "vpc-flow-logs"
  log_group_name = aws_cloudwatch_log_group.vpc_log_group.name
}

# Create CloudWatch metric filter for EKS container logs
resource "aws_cloudwatch_log_metric_filter" "eks_container_metric_filter" {
  name           = "eks-container-metric-filter"
  log_group_name = "/aws/eks/${var.cluster_name}/cluster"
  pattern        = "[timestamp, trace_id, span_id, level, message, component, namespace, object_name, object_kind, reason, api_group, api_version, resource_name, host, container_id, container_name, pod_id, pod_name, labels, annotations, custom_metadata, severity, kubernetes_host, kubernetes_labels, kubernetes_annotations, kubernetes_pod_name, kubernetes_container_name, kubernetes_namespace, kubernetes_pod_id, kubernetes_container_hash, kubernetes_container_image, kubernetes_cluster_name, kubernetes_container_started_at, kubernetes_container_finished_at] ?*"
  metric_transformation {
    name      = "EksContainerMetricFilterMatchCount"
    namespace = "EKSContainerLogs"
    value     = "1"
  }
}

# Create CloudWatch alarm for EKS container logs
resource "aws_cloudwatch_metric_alarm" "eks_container_metric_alarm" {
  alarm_name          = "EksContainerMetricAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "EksContainerMetricFilterMatchCount"
  namespace           = "EKSContainerLogs"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric indicates that EKS container logs are not being ingested into CloudWatch Logs."
  alarm_actions       = ["${var.notification_topic_arn}"]
  dimensions {
    kubernetes_namespace = var.namespace
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "app_security_group_id" {
  value = module.app_sg.security_group_id
}

output "rds_address" {
  value = module.rds.address
}

output "rds_security_group_id" {
  value = module.rds_sg.security_group_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_security_group_id" {
  value = module.eks_cluster_sg.security_group_id
}

output "eks_cluster_endpoint" {
  value = module.eks.endpoint
}
