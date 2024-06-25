resource "aws_secretsmanager_secret" "db_secret" {
  name        = "moodle-db-secret"
  description = "This secret contains the database credentials for Moodle"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    dbname   = var.db_name
    host     = aws_rds_cluster.aurora.endpoint
    port     = 3306
  })
}

output "db_secrets_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}
