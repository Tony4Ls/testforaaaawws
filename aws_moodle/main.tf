# Remove this block from main.tf
# provider "aws" {
#   region = var.region
# }

module "vpc" {
  source  = "./vpc"
  aws_region     = var.aws_region
  vpc_cidr       = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "eks" {
  source = "./eks"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_security_group_id = module.vpc.cluster_security_group_id
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  security_groups = [module.eks.cluster_security_group_id]
}

module "elasticache_rds" {
  source = "./elasticache_rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_secrets_arn = module.secrets_manager.db_secrets_arn
  security_groups = [module.eks.cluster_security_group_id]
}

module "secrets_manager" {
  source = "./secrets_manager"
  mariadb_user = var.mariadb_user
  mariadb_password = var.mariadb_password
}

data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}
