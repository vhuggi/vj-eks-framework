 variable "aws_region" {
  description = "The AWS region to create resources in."
  default = "us-west-2"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  default = "10.0.0.0/16"
}

variable "app_subnets" {
  description = "The comma-separated list of CIDR blocks for the application subnets."
  default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}

variable "db_subnets" {
  description = "The comma-separated list of CIDR blocks for the database subnets."
  default = "10.0.4.0/24,10.0.5.0/24,10.0.6.0/24"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance."
  default = "db.t2.micro"
}

variable "rds_username" {
  description = "The username for the RDS instance."
  default = "admin"
}

variable "rds_password" {
  description = "The password for the RDS instance."
}

variable "app_image" {
  description = "The Docker image for the application."
  default = "my-app:latest"
}

variable "redis_password" {
  description = "The password for the Redis instance."
}

