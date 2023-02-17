# VPC
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EKS
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "my-eks-cluster"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.20"
}

variable "fargate_profile_name" {
  type        = string
  description = "Name of the Fargate profile"
  default     = "fargate-profile"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity of the worker group"
  default     = 2
}

variable "max_capacity" {
  type        = number
  description = "Maximum capacity of the worker group"
  default     = 3
}

# RDS
variable "db_name" {
  type        = string
  description = "Name of the RDS database"
  default     = "mydb"
}

variable "db_username" {
  type        = string
  description = "Username for the RDS database"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS database"
  default     = "password"
}

variable "db_instance_class" {
  type        = string
  description = "Instance class for the RDS database"
  default     = "db.t2.micro"
}

# ALB
variable "alb_name" {
  type        = string
  description = "Name of the ALB"
  default     = "my-alb"
}

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
  default     = "my-target"
}

variable "alb_listener_port" {
  type        = number
  description = "Port for the ALB listener"
  default     = 80
}

# S3
variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = "my-bucket"
}

variable "s3_region" {
  type        = string
  description = "Region for the S3 bucket"
  default     = "us-west-2"
}

# CloudWatch
variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch log group"
  default     = "my-log-group"
}
