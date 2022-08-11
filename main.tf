data "aws_kms_alias" "default" {
  count = var.existing_kms_key_alias != "" ? 1 : 0
  name  = var.existing_kms_key_alias
}

resource "aws_secretsmanager_secret" "default" {
  count               = var.enabled ? 1 : 0
  name                = var.existing_kms_key_alias != "" ? "humn/${var.environment}/${replace(var.existing_kms_key_alias, "alias/", "")}/rds/${var.name}" : "humn/${var.environment}/rds/${var.name}"
  description         = "RDS secret for ${var.name}"
  rotation_lambda_arn = aws_lambda_function.lambda.0.arn
  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = data.aws_kms_alias.default.0.target_key_arn
  tags                    = module.label.tags
  depends_on              = []
}

resource "aws_secretsmanager_secret_version" "default" {
  count         = var.enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.default.0.id
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
