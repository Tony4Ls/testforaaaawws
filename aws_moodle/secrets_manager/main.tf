resource "aws_secretsmanager_secret" "moodle_db_secrets" {
  name = "moodle-db-secrets"

  secret_string = jsonencode({
    username = var.mariadb_user
    password = var.mariadb_password
  })
}

output "db_secrets_arn" {
  value = aws_secretsmanager_secret.moodle_db_secrets.arn
}
