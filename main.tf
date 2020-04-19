resource "aws_secretsmanager_secret" "default" {
  count               = var.enabled ? 1 : 0
  name                = "${lookup(var.secret_config, "db_name", "")}-secret"
  description         = "Managed by Terraform"
  rotation_lambda_arn = aws_lambda_function.lambda.0.arn
  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = aws_kms_key.default.0.key_id
  tags                    = module.label.tags
  depends_on              = []
}

resource "aws_secretsmanager_secret_version" "default" {
  count         = var.enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.default.*.id[count.index]
  secret_string = <<EOF
  {
    "engine": "${lookup(var.secret_config, "engine", "")}",
    "host": "${lookup(var.secret_config, "host", "")}",
    "username": "${lookup(var.secret_config, "username", "")}",
    "password": "${lookup(var.secret_config, "password", "")}",
    "dbname": "${lookup(var.secret_config, "dbname", "")}",
    "port": "${lookup(var.secret_config, "port", "")}"
  }
  EOF
}
