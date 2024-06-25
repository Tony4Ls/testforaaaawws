module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.23"
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  node_groups = {
    eks_nodes = {
      desired_capacity = var.eks_node_count
      max_capacity     = var.eks_node_max_count
      min_capacity     = var.eks_node_min_count
      instance_type    = var.eks_node_instance_type
    }
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
