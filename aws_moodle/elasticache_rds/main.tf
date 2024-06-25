variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "db_secrets_arn" {
  description = "ARN of the Secrets Manager secret for the database"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for the DB instances"
  type        = string
  default     = "db.r5.large"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "bitnami_moodle"
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "moodle-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"
  database_name           = var.db_name
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string).username
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string).password
  vpc_security_group_ids  = [module.eks.cluster_security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_db_subnet_group.name
  availability_zones      = ["us-east-1a", "us-east-1b"]
  skip_final_snapshot     = true

  tags = {
    Name = "moodle-aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count                = 2
  identifier           = "moodle-aurora-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = var.db_instance_class
  engine               = aws_rds_cluster.aurora.engine
  engine_version       = aws_rds_cluster.aurora.engine_version
  db_subnet_group_name = aws_db_subnet_group.aurora_db_subnet_group.name

  tags = {
    Name = "moodle-aurora-instance-${count.index}"
  }
}

resource "aws_db_subnet_group" "aurora_db_subnet_group" {
  name       = "aurora-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "aurora-db-subnet-group"
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

data "aws_secretsmanager_secret_version" "db_secrets" {
  secret_id = var.db_secrets_arn
}

output "rds_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.moodle_cache.cache_nodes[0].address
}
