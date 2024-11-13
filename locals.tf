# Define Local Values in Terraform
locals {
  appname = var.appname
  env = var.env
  owner = var.owner
  loc = var.loc
  workspace = "${var.env}-${var.appname}"
  common_tags = {
    appname = local.appname
    env = local.env
    owner = local.appname
    workspace = local.workspace
  }
} 