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

variable "availability_zones" {
  description = "(Required) - The AWS avaialbility zones (e.g. ap-southeast-2a/b/c). Autoloaded from region.tfvars."
  type        = list(string)
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-AWS-RDS-LAMBDA-ROTATION
# -----------------------------------------------------------------------------

variable "enabled" {
  description = "(Optional) -  A Switch that decides whether to create a terraform resource or run a provisioner. Default is true"
  type        = bool
  default     = true
}

variable "filename" {
  type        = string
  description = "(Optional) - The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
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
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"
}

variable "alias" {
  type        = string
  default     = "alias/secrets"
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash"
}

variable "policy" {
  type        = string
  default     = ""
  description = "A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
}

variable "secret_config" {
  description = "(Optional) A list of objects that contain RDS information including `username`, `password`, `port`, `hostname`, and 'arn' to create lambda rotation"
  type = object({
    engine               = string
    dbInstanceIdentifier = string
    host                 = string
    username             = string
    password             = string
    dbname               = string
    port                 = string
  })
  default = {
    engine               = "mysql"
    dbInstanceIdentifier = ""
    host                 = ""
    username             = "root"
    password             = ""
    dbname               = ""
    port                 = "3306"
  }
}

variable "automatically_after_days" {
  default     = 30
  description = "(Required) Specifies the number of days between automatic scheduled rotations of the secret"
}

variable "recovery_window_in_days" {
  default     = 0
  description = "(Optional) Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30."
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-LABEL - https://github.com/aciem-admin/tf-mod-label
# -----------------------------------------------------------------------------

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}


variable "context" {
  type = object({
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace           = ""
    environment         = ""
    stage               = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}
