resource "aws_secretsmanager_secret" "secrets_group" {
  name       = "/secret/${var.key_name}"
  kms_key_id = var.kms_arn
  tags       = var.tags

  recovery_window_in_days = 30
}

resource "aws_secretsmanager_secret_rotation" "secrets_rotation" {
  count               = var.rotation_lambda_arn == "" ? 0 : 1
  secret_id           = aws_secretsmanager_secret.secrets_group.id
  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }

  depends_on = [aws_secretsmanager_secret.secrets_group]
}


output "id" {
  value = aws_secretsmanager_secret.secrets_group.id
}
