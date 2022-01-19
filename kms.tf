resource "aws_kms_key" "default" {
  count                   = var.enabled ? 1 : 0
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  tags                    = module.kms_label.tags
  description             = "RDS Lambda rotation key, Managed by Terraform"
  policy                  = <<POLICY
{
  "Id": "key-consolepolicy-3",
  "Version": "2012-10-17",
  "Statement": [
     {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/humn-terraform-role"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda.0.arn}"
        ]
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow attachment of persistent resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda.0.arn}"
        ]
      },
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": "true"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_kms_alias" "default" {
  count         = var.enabled == true ? 1 : 0
  name          = coalesce(var.alias, format("alias/%v", "rds-rotation-key"))
  target_key_id = aws_kms_key.default.0.id
}
