provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc.tf"
}

module "eks" {
  source = "./eks.tf"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "alb" {
  source = "./alb.tf"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "moodle" {
  source = "./moodle.tf"
  cluster_name = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_certificate_authority = module.eks.cluster_certificate_authority
  private_subnets = module.vpc.private_subnets
  alb_dns_name = module.alb.alb_dns_name
  db_secrets_arn = module.secrets_manager.db_secrets_arn
}

module "cloudfront_route53" {
  source = "./cloudfront_route53.tf"
  alb_dns_name = module.alb.alb_dns_name
  domain_name  = var.domain_name
}

module "elasticache_rds" {
  source = "./elasticache_rds.tf"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_secrets_arn = module.secrets_manager.db_secrets_arn
}

module "secrets_manager" {
  source = "./secrets_manager.tf"
}
