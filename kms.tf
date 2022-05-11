

data "aws_iam_policy_document" "kms_policy" {
  count = var.enabled == true && var.existing_kms_key_alias == "" ? 1 : 0
  statement {
    sid = "Enable IAM User Permissions"

    actions = [
      "kms:*"
    ]

    resources = [
      "*",
    ]

    principals {
      type        = "AWS"
      identifiers = var.kms_admin
    }
  }

  statement {
    sid = "Allow use of the key"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = [
      "*",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.lambda.0.arn]
    }
  }

  statement {
    sid = "Allow attachment of persistent resources"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    resources = [
      "*",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.lambda.0.arn]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

resource "aws_kms_key" "default" {
  count                   = var.enabled == true && var.existing_kms_key_alias == "" ? 1 : 0
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  tags                    = module.kms_label.tags
  description             = "RDS Lambda rotation key, Managed by Terraform"
  policy                  = data.aws_iam_policy_document.kms_policy.json
}

resource "aws_kms_alias" "default" {
  count         = var.enabled == true && var.existing_kms_key_alias == "" ? 1 : 0
  name          = coalesce(var.alias, format("alias/%v", "rds-rotation-key"))
  target_key_id = aws_kms_key.default.0.id
}
