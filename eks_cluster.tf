resource "aws_eks_cluster" "moodle" {
  name     = "moodle-cluster"
  role_arn = "arn:aws:iam::<your-account-id>:role/LabRole"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}