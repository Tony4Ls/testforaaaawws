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

variable "moodle_admin_user" {
  description = "Admin username for Moodle"
  type        = string
}

variable "moodle_admin_password" {
  description = "Admin password for Moodle"
  type        = string
}

variable "moodle_admin_email" {
  description = "Admin email for Moodle"
  type        = string
}

variable "mariadb_root_password" {
  description = "Root password for MariaDB"
  type        = string
}

variable "mariadb_user" {
  description = "Username for MariaDB"
  type        = string
}

variable "mariadb_password" {
  description = "Password for MariaDB"
  type        = string
}

variable "mariadb_database" {
  description = "Database name for MariaDB"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the CloudFront distribution"
  type        = string
  default     = "commoncloud.tech"
}

variable "db_instance_class" {
  description = "Instance class for the DB instances"
  type        = string
  default     = "db.r5.large"
}
