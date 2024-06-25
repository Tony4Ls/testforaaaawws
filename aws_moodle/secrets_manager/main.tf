resource "aws_secretsmanager_secret" "moodle_db_secrets" {
  name = "moodle-db-secrets"
}

resource "aws_secretsmanager_secret_version" "moodle_db_secrets_version" {
  secret_id     = aws_secretsmanager_secret.moodle_db_secrets.id
  secret_string = jsonencode({
    username = var.mariadb_user
    password = var.mariadb_password
  })
}

output "db_secrets_arn" {
  value = aws_secretsmanager_secret.moodle_db_secrets.arn
}
