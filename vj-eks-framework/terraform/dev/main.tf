module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "${var.environment}-vpc"
  cidr                 = var.cidr_block
  azs                  = var.availability_zones
  private_subnets      = var.private_subnet_cidrs
  public_subnets       = var.public_subnet_cidrs
  enable_nat_gateway   = true
  single_nat_gateway   = true
  create_database_subnet_group = true
}

module "eks" {
  source = "../modules/eks"

  cluster_name = "${var.environment}-eks-cluster"
  subnets      = module.vpc.private_subnets
  tags         = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "rds" {
  source = "terraform-aws-modules/rds/aws"

  name = "${var.environment}-rds"
  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  engine = "mysql"
  engine_version = "8.0.23"
  instance_class = "db.t2.micro"
  username = "admin"
  password = random_password.password.result
  allocated_storage = 20
  storage_type = "gp2"
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "random_password" "password" {
  length  = 16
  special = true
}

module "alb" {
  source = "../modules/eks"

  cluster_name  = module.eks.eks_cluster_name
  namespace     = "default"
  service_name  = "app"
  service_port  = 80
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

output "rds_address" {
  value = module.rds.this_db_instance_address
}

output "rds_port" {
  value = module.rds.this_db_instance_port
}

output "alb_dns_name" {
  value = module.alb.this_lb_dns_name
}
