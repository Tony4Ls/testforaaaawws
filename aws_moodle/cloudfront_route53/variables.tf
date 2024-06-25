variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the CloudFront distribution"
  type        = string
}
