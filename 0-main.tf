provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::339712807760:role/LabRole"
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.moodle.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.moodle.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.moodle.token
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.moodle.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.moodle.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.moodle.token
  }
}
