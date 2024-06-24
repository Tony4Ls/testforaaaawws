resource "aws_eks_node_group" "moodle" {
  cluster_name    = aws_eks_cluster.moodle.name
  node_group_name = "moodle-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]  # Choose appropriate instance types

  depends_on = [aws_eks_cluster.moodle]
}