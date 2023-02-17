 resource "aws_security_group" "eks_cluster" {
  name_prefix = "eks-cluster"
  description = "Security group for EKS cluster"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "Allow internal communication"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


### These files configure security groups for the cluster and its resources.
