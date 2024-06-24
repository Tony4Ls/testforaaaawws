resource "aws_eks_cluster" "moodle" {
  name     = "moodle-cluster"
  role_arn = "arn:aws:iam::<your-account-id>:role/LabRole"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_a.id,
      aws_subnet.public_b.id,
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}

resource "aws_eks_node_group" "moodle" {
  cluster_name    = aws_eks_cluster.moodle.name
  node_group_name = "moodle-nodes"
  node_role_arn   = "arn:aws:iam::<your-account-id>:role/L