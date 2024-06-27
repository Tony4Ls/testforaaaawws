variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.6.0.0/16"
}

variable "vpc_name" {
  description = "The name tag for the VPC"
  type        = string
  default     = "4122-vpc"
}

variable "rds_master_password" {
  description = "The master password for the RDS instance"
  type        = string
  default     = "admin1234"
  sensitive   = true
}

variable "rds_master_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "rds_engine_version" {
  description = "The engine version for the RDS instance"
  type        = string
  default     = "5.7.mysql_aurora.2.07.2"
}
