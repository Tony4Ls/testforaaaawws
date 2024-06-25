resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = var.vpc_id
  tags = {
    Name = "moodle-eks-cluster-sg"
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {
    subnet_ids         = var.private_subnets
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "moodle-node-group"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 0
  }

  instance_types = ["t3.medium"]

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

output "cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}
