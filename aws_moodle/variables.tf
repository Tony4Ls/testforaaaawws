variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "moodle-cluster"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.30"
}

variable "mariadb_user" {
  description = "Username for MariaDB"
  type        = string
}

variable "mariadb_password" {
  description = "Password for MariaDB"
  type        = string
}
