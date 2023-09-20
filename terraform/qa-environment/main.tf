module "qa-env" {
  source = "git::https://github.com/divakarvr/diva-tf-modules.git?ref=vpc-module"

  cidr_block = var.cidr
  tag_name   = var.tag
  cidr_subnet = var.cidr_subnet
}