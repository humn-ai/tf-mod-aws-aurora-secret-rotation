# -----------------------------------------------------------------------------
# Variables: Common AWS Provider - Autoloaded from Terragrunt
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = "The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars"
  type        = string
  default     = ""
}

variable "aws_assume_role_arn" {
  description = "(Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars."
  type        = string
  default     = ""
}

variable "aws_assume_role_session_name" {
  description = "(Optional) - The session name to use when making the AssumeRole call."
  type        = string
  default     = ""
}

variable "aws_assume_role_external_id" {
  description = "(Optional) - The external ID to use when making the AssumeRole call."
  type        = string
  default     = ""
}
existing_kms_key_alias

variable "existing_kms_key_alias" {
  description = "(Optional) - The display name of the alias. If no existing alias is specified, terraform will create one."
  type        = string
  default     = ""
}

variable "availability_zones" {
  description = "(Required) - The AWS avaialbility zones (e.g. ap-southeast-2a/b/c). Autoloaded from region.tfvars."
  type        = list(string)
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-AWS-MYSQL-SECRET-ROTATION
# -----------------------------------------------------------------------------

variable "enabled" {
  description = "(Optional) -  A Switch that decides whether to create a terraform resource or run a provisioner. Default is true"
  type        = bool
  default     = true
}

variable "dbclusteridentifier" {
  type        = string
  description = "(Required) - The dbclusteridentifier of the rds cluster."
  default     = ""
}

// vpc_config requires the following:
variable "subnet_ids" {
  description = "(Required) - A list of subnet IDs associated with the Lambda function."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) - List of Security Group IDs that are allowed ingress to the Lambda function"
}


variable "deletion_window_in_days" {
  default     = 10
  description = "(Optional) - Duration in days after which the key is deleted after destruction of the resource"
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "(Optional) - The description of the key as viewed in AWS console"
}

variable "alias" {
  type        = string
  default     = "alias/secrets"
  description = "(Optional) - The display name of the alias. The name must start with the word `alias` followed by a forward slash"
}

variable "kms_admin" {
  type        = list(string)
  default     = []
  description = "(Required) - KMS Key policy admin. List of ARNs for the KMS admin"
}

variable "policy" {
  type        = string
  default     = ""
  description = "(Optional) - A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
}

variable "secret_config" {
  description = "(Optional) A list of objects that contain RDS information including `username`, `password`, `port`, `hostname`, and 'arn' to create lambda rotation"
  type = object({
    engine   = string
    host     = string
    username = string
    password = string
    dbname   = string
    port     = string
  })
  default = {
    engine   = "postgres"
    host     = ""
    username = "root"
    password = ""
    dbname   = ""
    port     = "5432"
  }
}

variable "secretsmanager_vpc_endpoint" {
  description = "(Optional) The VPC endpoint configured for the AWS Secrets Manager service for private access from within the VPC"
  default     = ""
  type        = string
}

variable "automatically_after_days" {
  default     = 360
  description = "(Required) Specifies the number of days between automatic scheduled rotations of the secret"
}

variable "recovery_window_in_days" {
  default     = 0
  description = "(Optional) Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30."
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "(Optional) - Specifies whether key rotation is enabled"
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-LABEL
# -----------------------------------------------------------------------------

variable "namespace" {
  type        = string
  default     = ""
  description = "(Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "(Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod'"
}

variable "name" {
  type        = string
  default     = ""
  description = "(Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "(Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "(Optional) - Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) - Additional tags"
}
