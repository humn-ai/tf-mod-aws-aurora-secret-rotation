module "label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(var.attributes, ["secret"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "lambda_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["function"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "kms_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["kms"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "role_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["role"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}

module "policy_label" {
  source             = "git::https://github.com/Callumccr/tf-mod-label.git?ref=master"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = concat(module.label.attributes, ["policy"])
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"]
}
