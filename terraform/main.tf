provider "aws" {
  region = var.aws_region
}

# Include other Terraform files
module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "moodle" {
  source = "./moodle"
  cluster_name = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_certificate_authority = module.eks.cluster_certificate_authority
  private_subnets = module.vpc.private_subnets
  alb_dns_name = module.alb.alb_dns_name
}

module "cloudfront_route53" {
  source = "./cloudfront_route53"
  alb_dns_name = module.alb.alb_dns_name
}

module "elasticache_rds" {
  source = "./elasticache_rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}