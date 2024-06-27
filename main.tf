provider "aws" {
  region = var.region
}

data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "moodle_vpc" {
  cidr_block = "10.6.0.0/16"
  tags = {
    Name = "4122-vpc"
  }
}

resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = aws_vpc.moodle_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.moodle_vpc.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "4122-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.moodle_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.moodle_vpc.cidr_block, 8, count.index + 2)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "4122-public-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.moodle_vpc.id
  tags = {
    Name = "4122-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.moodle_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "4122-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id  # Place NAT Gateway in the first public subnet
  tags = {
    Name = "4122-nat-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.moodle_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "4122-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
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
  node_role_arn   = data.aws_iam_role.lab_role.arn  # Corrected IAM role ARN
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}
