resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.moodle_vpc.id
  tags = {
    Name = "4122-rds-sg"
  }
}

resource "aws_security_group_rule" "allow_moodle_to_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "aurora-subnet-group"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = var.rds_engine_version
  master_username         = var.rds_master_username
  master_password         = var.rds_master_password
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true

  tags = {
    Name = "aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_writer" {
  identifier           = "aurora-writer"
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  instance_class       = "db.r5.large"
  engine               = aws_rds_cluster.aurora_cluster.engine
  engine_version       = aws_rds_cluster.aurora_cluster.engine_version

  tags = {
    Name = "aurora-writer"
  }
}

resource "aws_rds_cluster_instance" "aurora_reader" {
  identifier           = "aurora-reader"
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  instance_class       = "db.r5.large"
  engine               = aws_rds_cluster.aurora_cluster.engine
  engine_version       = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible  = false

  tags = {
    Name = "aurora-reader"
  }
}
