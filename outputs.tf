# -----------------------------------------------------------------------------
# Outputs: TF-MOD-AWS-MYSQL-SECRET-ROTATION
# -----------------------------------------------------------------------------

output "key_arn" {
  value       = join("", aws_kms_key.default.*.arn)
  description = "Key ARN"
}

output "key_id" {
  value       = join("", aws_kms_key.default.*.key_id)
  description = "Key ID"
}

output "alias_arn" {
  value       = join("", aws_kms_alias.default.*.arn)
  description = "Alias ARN"
}

output "alias_name" {
  value       = join("", aws_kms_alias.default.*.name)
  description = "Alias name"
}

output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.lambda.*.arn
}

output "lambda_ids" {
  description = "The name of the VPC Lambda functions"
  value       = aws_lambda_function.lambda.*.function_name
}

output "role_arn" {
  description = "The ARN of the IAM role created for the Lambda function"
  value       = aws_iam_role.lambda.*.arn
}

output "role_name" {
  description = "The name of the IAM role created for the Lambda function"
  value       = aws_iam_role.lambda.*.name
}

output "secret_id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = aws_secretsmanager_secret.default.*.name
}
