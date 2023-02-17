output "app_node_group_instance_profile_name" {
  value = aws_iam_instance_profile.app_node_group.name
}

output "app_node_group_security_group_id" {
  value = aws_security_group.app_node_group.id
}

output "app_node_group_role_arn" {
  value = aws_iam_role_policy_attachment.app_node_group_role_attachment.role_arn
}

output "app_node_group_arn" {
  value = aws_eks_node_group.app_node_group.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "db_address" {
  value = aws_db_instance.rds.address
}

output "db_port" {
  value = aws_db_instance.rds.port
}

output "redis_primary_endpoint_address" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_primary_endpoint_port" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_port
}



