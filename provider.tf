provider "aws" {
  version             = "~> 3.69.0"
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
  assume_role {
    role_arn = var.aws_assume_role_arn
  }
}
