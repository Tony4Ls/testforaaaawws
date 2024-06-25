module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  node_group_defaults {
    ami_type        = "AL2_x86_64"
    instance_type   = var.eks_node_instance_type
    desired_size    = var.eks_node_count
    min_size        = var.eks_node_min_count
    max_size        = var.eks_node_max_count
  }

  tags = {
    Name = "moodle-eks"
  }
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority" {
  value = module.eks.cluster_certificate_authority
}
