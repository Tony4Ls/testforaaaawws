variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  type        = string
}

variable "cluster_certificate_authority" {
  description = "The certificate authority for the EKS cluster"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "db_secrets_arn" {
  description = "The ARN of the database secrets"
  type        = string
}
