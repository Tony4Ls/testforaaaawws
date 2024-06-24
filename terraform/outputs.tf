output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "cloudfront_domain_name" {
  value = module.cloudfront_route53.cloudfront_domain_name
}

output "rds_endpoint" {
  value = module.elasticache_rds.rds_endpoint
}

output "redis_endpoint" {
  value = module.elasticache_rds.redis_endpoint
}
