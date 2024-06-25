resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "moodle-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  master_username         = var.mariadb_user
  master_password         = var.mariadb_password
  database_name           = "moodle"
  vpc_security_group_ids  = var.security_groups
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot     = true
  deletion_protection     = false
  port                    = 3306

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_elasticache_subnet_group" "elasticache" {
  name       = "moodle-cache"
  subnet_ids = var.private_subnets
  tags = {
    Name = "moodle-cache"
  }
}

resource "aws_elasticache_cluster" "moodle_cache" {
  cluster_id           = "moodle-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.elasticache.name
  security_group_ids   = var.security_groups
}
