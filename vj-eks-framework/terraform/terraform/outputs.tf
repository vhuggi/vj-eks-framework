output "eks_cluster_name" {
description = "The name of the EKS cluster."
value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
description = "The endpoint of the EKS cluster."
value = module.eks.cluster_endpoint
}

output "eks_worker_security_group_id" {
description = "The ID of the security group for the EKS worker nodes."
value = module.eks.worker_security_group_id
}

output "s3_bucket_arn" {
description = "The ARN of the S3 bucket."
value = module.s3.arn
}