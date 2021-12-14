module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(var.attributes, ["secret"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["namespace", "environment", "name", "attributes"]
}

module "lambda_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["function"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["namespace", "environment", "name", "attributes"]
}

module "kms_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["kms"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["namespace", "environment", "name", "attributes"]
}

module "role_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["role"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["namespace", "environment", "name", "attributes"]
}

module "policy_label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["policy"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["namespace", "environment", "name", "attributes"]
}
