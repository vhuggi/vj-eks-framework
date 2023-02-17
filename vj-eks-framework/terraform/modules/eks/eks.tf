data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.0.0"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  private_subnets = split(",", var.app_subnets)
  public_subnets  = split(",", var.db_subnets)

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "12.0.0"

  cluster_name = "my-eks-cluster"
  subnets      = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "rds" {
  source = "terraform-aws-modules/rds/aws"
  version = "2.12.0"

  db_name           = "mydb"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = var.rds_instance_class
  username          = var.rds_username
  password          = var.rds_password
  allocated_storage = 10
  storage_type      = "gp2"
  subnet_ids        = module.vpc.private_subnets

  vpc_security_group_ids = [module.rds_sg.security_group_id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name_prefix = "alb-sg"
  description = "Security group for Application Load Balancer"

  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  ingress_rules = [
    {
      description      = "Allow HTTP traffic from the VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      source_security_group_id = module.app_sg.security_group_id
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name_prefix = "app-sg"
  description = "Security group for application instances"

  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  ingress_rules = [
    {
      description      = "Allow HTTP traffic from the ALB"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      description      = "Allow MySQL traffic from the RDS instance"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      source_security_group_id = module.rds_sg.security_group_id
    },
  ]

  egress_rules = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name_prefix = "rds-sg"
  description = "Security group for RDS instance"

  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  ingress_rules = [
    {
      description      = "Allow MySQL traffic from the application instances"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      source_security_group_id = module.app_sg.security_group_id
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


##### These files configure the EKS cluster #####
