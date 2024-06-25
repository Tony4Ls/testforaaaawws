variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "eks_node_instance_type" {
  description = "The EC2 instance type for the EKS nodes"
  type        = string
}

variable "eks_node_count" {
  description = "The desired number of EKS nodes"
  type        = number
}

variable "eks_node_max_count" {
  description = "The maximum number of EKS nodes"
  type        = number
}

variable "eks_node_min_count" {
  description = "The minimum number of EKS nodes"
  type        = number
}
