variable "name" {
  description = "The name of the EKS cluster."
  type = string
}

variable "region" {
  description = "The region in which to create the EKS cluster."
  type = string
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type = string
}

variable "azs" {
  description = "The availability zones to use for the VPC."
  type = list(string)
}

variable "private_subnets" {
  description = "The private subnets to create in the VPC."
  type = list(string)
}

variable "public_subnets" {
  description = "The public subnets to create in the VPC."
  type = list(string)
}

variable "desired_capacity" {
  description = "The desired capacity of the EKS worker nodes."
  type = number
  default = 3
}

variable "min_size" {
  description = "The minimum size of the EKS worker node group."
  type = number
  default = 1
}

variable "max_size" {
  description = "The maximum size of the EKS worker node group."
  type = number
  default = 3
}

variable "instance_type" {
  description = "The instance type of the EKS worker nodes."
  type = string
  default = "t3.medium"
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile to create."
  type = string
  default = "default"
}

variable "app_image_repo" {
  description = "The name of the Docker image repository for the application."
type = string
}

variable "app_image_tag" {
description = "The tag of the Docker image for the application."
type = string
}

variable "db_name" {
description = "The name of the RDS database."
type = string
default = "mydb"
}

variable "db_username" {
description = "The username for the RDS database."
type = string
default = "admin"
}

variable "db_password" {
description = "The password for the RDS database."
type = string
}

variable "db_instance_class" {
description = "The instance class for the RDS database."
type = string
default = "db.t3.micro"
}

variable "db_allocated_storage" {
description = "The amount of storage to allocate for the RDS database."
type = number
default = 20
}

variable "db_engine" {
description = "The database engine to use for the RDS database."
type = string
default = "mysql"
}

variable "db_engine_version" {
description = "The version of the database engine to use for the RDS database."
type = string
default = "5.7"
}

variable "bucket_name" {
description = "The name of the S3 bucket to create."
type = string
}

variable "versioning" {
description = "Whether to enable versioning on the S3 bucket."
type = bool
default = true
}

variable "tags" {
description = "The tags to apply to the S3 bucket."
type = map(string)
default = {}
}
