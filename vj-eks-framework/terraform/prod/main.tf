module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my-vpc"
  cidr   = var.vpc_cidr_block
}

module "eks" {
  source                     = "terraform-aws-modules/eks/aws"
  cluster_name               = var.cluster_name
  subnets                    = module.vpc.private_subnets
  vpc_id                     = module.vpc.vpc_id
  create_fargate_pod_profile = true
  fargate_profile_name       = "default"
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.15.0"

  identifier = var.rds_identifier
  name       = var.rds_name

  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage

  vpc_security_group_ids = [module.eks.cluster_security_group_id]

  subnets = module.vpc.private_subnets

  snapshot_identifier = var.rds_snapshot_identifier

  parameter_group_name = var.rds_parameter_group_name

  maintenance_window = var.rds_maintenance_window
  backup_window      = var.rds_backup_window

  skip_final_snapshot = var.rds_skip_final_snapshot
}

module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = var.elb_name

  subnets         = module.vpc.public_subnets
  security_groups = [module.eks.cluster_security_group_id]

  internal = false
  alb_type = "application"

  access_logs = [
    {
      bucket = var.elb_logs_s3_bucket_name
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "production"
  }

  // Enable HTTPS
  https_listener = {
    certificate_arn = var.https_listener_certificate_arn
    port            = 443
  }

  // Configure health check
  target_group_health_check = {
    path = "/healthz"
  }
}

module "monitoring" {
  source = "terraform-aws-modules/cloudwatch/aws"
  version = "1.2.0"

  namespace  = var.monitoring_namespace
  log_group  = var.monitoring_log_group
  stream_name = var.monitoring_stream_name
  alarm_actions = [var.monitoring_alarm_actions]
}

