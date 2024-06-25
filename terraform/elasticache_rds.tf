resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "moodle-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  parameter_group_name = "default.redis3.2"
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "moodle-aurora"
  engine                  = "aurora"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name
}

resource "aws_rds_cluster_instance" "aurora_primary" {
  identifier               = "moodle-aurora-primary"
  cluster_identifier       = aws_rds_cluster.aurora.id
  instance_class           = "db.t3.medium"
  engine                   = aws_rds_cluster.aurora.engine
  engine_version           = aws_rds_cluster.aurora.engine_version
  publicly_accessible      = false
  db_subnet_group_name     = aws_db_subnet_group.main.name
  availability_zone        = element(data.aws_availability_zones.available.names, 0)
}

resource "aws_rds_cluster_instance" "aurora_replica" {
  identifier               = "moodle-aurora-replica"
  cluster_identifier       = aws_rds_cluster.aurora.id
  instance_class           = "db.t3.medium"
  engine                   = aws_rds_cluster.aurora.engine
  engine_version           = aws_rds_cluster.aurora.engine_version
  publicly_accessible      = false
  db_subnet_group_name     = aws_db_subnet_group.main.name
  availability_zone        = element(data.aws_availability_zones.available.names, 1)
}

resource "aws_db_subnet_group" "main" {
  name       = "aurora-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "moodle-rds-sg"
  }
}

output "rds_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}
