data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "aurora-subnet-group"
  }
}

resource "aws_security_group" "aurora_sg" {
  vpc_id = aws_vpc.moodle_vpc.id
  tags = {
    Name = "aurora-sg"
  }
}

resource "aws_security_group_rule" "allow_eks_to_aurora" {
  type                     = "ingress"
  from_port                = 3306  # MySQL/Aurora default port
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.aurora_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = var.rds_engine_version
  master_username         = var.rds_master_username
  master_password         = var.rds_master_password
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]  # Use the new Aurora SG
  skip_final_snapshot     = true

  tags = {
    Name = "aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_primary" {
  identifier           = "aurora-primary"  # Updated identifier for the primary instance
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  instance_class       = "db.t3.medium"  # Updated instance class
  engine               = aws_rds_cluster.aurora_cluster.engine
  engine_version       = aws_rds_cluster.aurora_cluster.engine_version

  tags = {
    Name = "aurora-primary"
  }
}

resource "aws_rds_cluster_instance" "aurora_reader" {
  identifier           = "aurora-reader"
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  instance_class       = "db.t3.medium"  # Updated instance class
  engine               = aws_rds_cluster.aurora_cluster.engine
  engine_version       = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible  = false

  tags = {
    Name = "aurora-reader"
  }
}
