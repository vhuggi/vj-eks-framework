environment = "prod"

cluster_name = "my-eks-cluster"

vpc_id = "vpc-123456789012"

public_subnet_ids = ["subnet-123456789012", "subnet-123456789013", "subnet-123456789014"]

private_subnet_ids = ["subnet-123456789015", "subnet-123456789016", "subnet-123456789017"]

app_node_group_instance_type = "t3.medium"

app_node_group_desired_capacity = 2

app_node_group_max_size = 5

app_node_group_min_size = 1

app_node_group_volume_size = 20

alb_name = "my-alb"

alb_listener_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:listener/app/my-alb/1234567890abcdef/1234567890abcdef"

db_instance_class = "db.t3.small"

db_username = "admin"

db_password = "MyRdsPassword123"

db_name = "mydb"

redis_instance_type = "cache.t3.micro"

redis_engine_version = "5.0.6"

redis_parameter_group_name = "default.redis5.0"

redis_num_cache_clusters = 1

redis_port = 6379

redis_password = "MyRedisPassword123"
