output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "moodle_url" {
  value = module.moodle.hostname
}
