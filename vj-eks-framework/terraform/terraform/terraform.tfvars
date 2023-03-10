name = "my-eks-cluster"
region = "us-east-1"
cidr = "10.0.0.0/16"
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
desired_capacity = 3
min_size = 1
max_size = 3
instance_type = "t3.medium"
fargate_profile_name = "default"
app_image_repo = "myrepo/myapp"
app_image_tag = "latest"
db_name = "mydb"
db_username = "admin"
db_password = "mypassword"
db_instance_class = "db.t3.micro"
db_allocated_storage = 20
db_engine = "mysql"
db_engine_version = "5.7"
bucket_name = "my-bucket"
versioning = true
tags = {
"environment" = "dev"
}