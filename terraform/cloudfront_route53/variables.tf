variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "domain_name" {
  description = "The DNS name for the Route 53 hosted zone"
  type        = string
}
