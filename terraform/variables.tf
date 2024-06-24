variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default = "moodle-cluster"
}

variable "eks_node_instance_type" {
  description = "The EC2 instance type for the EKS nodes"
  default = "t3.medium"
}

variable "eks_node_count" {
  description = "The number of EKS nodes"
  default = 2
}

variable "eks_node_max_count" {
  description = "The maximum number of EKS nodes"
  default = 3
}

variable "eks_node_min_count" {
  description = "The minimum number of EKS nodes"
  default = 1
}

variable "db_username" {
  description = "The username for the RDS instance"
  default = "admin"
}

variable "db_password" {
  description = "The password for the RDS instance"
  default = "yourpassword"
}

variable "db_name" {
  description = "The name of the database for Moodle"
  default = "moodle"
}

variable "domain_name" {
  description = "The DNS name for the application"
  default = "commoncloud.tech"
}
