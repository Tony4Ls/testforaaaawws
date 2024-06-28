module "vpc" {
  source     = "./vpc.tf"
}

module "eks" {
  source     = "./eks.tf"
}

module "rds" {
  source     = "./rds.tf"
}

module "k8s" {
  source     = "./k8s.tf"
}
