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
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "moodle" {
  source = "./moodle"
  moodle_admin_user = var.moodle_admin_user
  moodle_admin_password = var.moodle_admin_password
  moodle_admin_email = var.moodle_admin_email
  mariadb_root_password = var.mariadb_root_password
  mariadb_user = var.mariadb_user
  mariadb_password = var.mariadb_password
  mariadb_database = var.mariadb_database
  private_subnets = module.vpc.private_subnets
  alb_dns_name = module.alb.alb_dns_name
  db_secrets_arn = module.secrets_manager.db_secrets_arn
}

module "cloudfront_route53" {
  source = "./cloudfront_route53"
  alb_dns_name = module.alb.alb_dns_name
  domain_name = var.domain_name
}

module "elasticache_rds" {
  source = "./elasticache_rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_secrets_arn = module.secrets_manager.db_secrets_arn
}

module "secrets_manager" {
  source = "./secrets_manager"
}
