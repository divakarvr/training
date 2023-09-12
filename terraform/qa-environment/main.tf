module "qa-env" {
  source = "../tf-modules/networking"

  cidr_block = var.cidr
  tag_name   = var.tag
}