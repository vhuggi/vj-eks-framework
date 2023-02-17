 output "vpc_id" {
  description = "The ID of the VPC."
}

output "private_subnets" {
  description = "The IDs of the private subnets."
}

output "app_security_group_id" {
  description = "The ID of the application security group."
}

output "rds_address" {
  description = "The address of the RDS instance."
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group."
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
}

output "eks_cluster_security_group_id" {
  description = "The ID of the EKS cluster security group."
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
}

