# Application settings
app_name            = "myapp"
app_port            = "80"
app_replicas        = 2

# Networking settings
vpc_cidr_block      = "10.0.0.0/16"
public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# RDS settings
db_engine           = "mysql"
db_instance_class   = "db.t2.micro"
db_allocated_storage = 20
db_username         = "admin"

# EKS settings
eks_fargate_profile = true
eks_node_groups      = []

# ALB settings
alb_target_group_stickiness_duration = 1800
