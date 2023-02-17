 resource "aws_security_group_rule" "app_to_rds" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  description = "Allow traffic from the application security group to the RDS security group"

  security_group_id = module.rds_sg.security_group_id
  source_security_group_id = module.app_sg.security_group_id
}

resource "aws_security_group_rule" "eks_to_rds" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  description = "Allow traffic from the EKS security group to the RDS security group"

  security_group_id = module.rds_sg.security_group_id
  source_security_group_id = module.eks.eks_cluster_sg_id
}

