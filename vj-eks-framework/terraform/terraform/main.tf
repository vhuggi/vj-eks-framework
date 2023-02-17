provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.name
  cidr = var.cidr
  azs = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true
}

module "eks" {
  source = "./modules/eks"
  name = var.name
  region = var.region
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
  instance_type = var.instance_type
  fargate_profile_name = var.fargate_profile_name
  app_image_repo = var.app_image_repo
  app_image_tag = var.app_image_tag
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_instance_class = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine = var.db_engine
  db_engine_version = var.db_engine_version
}

module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket_name = var.bucket_name
  versioning = var.versioning
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
}
