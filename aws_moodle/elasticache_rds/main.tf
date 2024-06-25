resource "aws_db_instance" "moodle_db" {
  identifier        = "moodle-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  name              = var.mariadb_database
  username          = var.mariadb_user
  password          = var.mariadb_password
  vpc_security_group_ids = [module.eks.cluster_security_group_id]
  db_subnet_group_name  = aws_db_subnet_group.moodle_db_subnet_group.name

  skip_final_snapshot = true

  tags = {
    Name = "moodle-db"
  }
}

resource "aws_db_subnet_group" "moodle_db_subnet_group" {
  name       = "moodle-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "moodle-db-subnet-group"
  }
}

resource "aws_elasticache_cluster" "moodle_cache" {
  cluster_id           = "moodle-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  subnet_group_name    = aws_elasticache_subnet_group.moodle_cache_subnet_group.name
  security_group_ids   = [module.eks.cluster_security_group_id]

  tags = {
    Name = "moodle-cache"
  }
}

resource "aws_elasticache_subnet_group" "moodle_cache_subnet_group" {
  name       = "moodle-cache-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "moodle-cache-subnet-group"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.moodle_db.endpoint
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.moodle_cache.cache_nodes[0].address
}
