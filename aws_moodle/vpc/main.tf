module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"  # Ensure this is a version that does not include deprecated arguments

  name = "moodle-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true  # Use a single NAT Gateway for all private subnets

  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "moodle-vpc"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
