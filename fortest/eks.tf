data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.moodle_vpc.id
  tags = {
    Name = "4122-eks-cluster-sg"
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "4122-eks-cluster"
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "4122-node-group"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "helm_release" "aws_ebs_csi_driver" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = "2.4.0"

  values = [
    <<EOF
controller:
  tolerations:
    - key: node.kubernetes.io/not-ready
      operator: Exists
    - key: node.kubernetes.io/unreachable
      operator: Exists
EOF
  ]
}
