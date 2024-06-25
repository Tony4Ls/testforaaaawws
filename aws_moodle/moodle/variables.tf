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

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "db_secrets_arn" {
  description = "ARN of the Secrets Manager secret for the database"
  type        = string
}
