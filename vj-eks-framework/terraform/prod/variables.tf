variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "eks_cluster_name" {
  default = "my-eks-cluster"
}

variable "eks_fargate_profile_name" {
  default = "my-fargate-profile"
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "changeme"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "8.0"
}

variable "db_port" {
  default = 3306
}

variable "db_multi_az" {
  default = false
}

variable "db_backup_retention_period" {
  default = 7
}

variable "db_subnet_group_name" {
  default = "my-rds-subnet-group"
}

variable "app_replica_count" {
  default = 2
}

variable "app_image" {
  default = "nginx:latest"
}

variable "app_container_port" {
  default = 80
}

variable "app_service_type" {
  default = "ClusterIP"
}

variable "app_hosted_zone_name" {
  default = "example.com"
}

variable "app_domain_name" {
  default = "my-app.example.com"
}

variable "app_ingress_controller_version" {
  default = "0.47.0"
}

variable "app_health_check_path" {
  default = "/"
}

variable "cloudwatch_log_group_name" {
  default = "/aws/eks/my-eks-cluster/my-app"
}

variable "redis_engine" {
  default = "redis"
}

variable "redis_name" {
  default = "my-redis-cluster"
}

variable "redis_node_type" {
  default = "cache.t2.micro"
}

variable "redis_port" {
  default = 6379
}

variable "redis_subnet_group_name" {
  default = "my-redis-subnet-group"
}

variable "redis_num_cache_nodes" {
  default = 1
}

variable "redis_snapshot_window" {
  default = "02:00-03:00"
}

variable "redis_snapshot_retention_limit" {
  default = 5
}

variable "cloudwatch_alarm_sns_topic" {
  default = "arn:aws:sns:us-east-1:123456789012:my-cloudwatch-alarms"
}

variable "slack_webhook_url" {
  default = "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX"
}

variable "slack_channel" {
  default = "#my-channel"
}

variable "slack_username" {
  default = "my-bot"
}
