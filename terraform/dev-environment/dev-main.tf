module "qa-env" {
  source = "../tf-modules/networking"

  vpc_cidr             = var.cidr
  environment          = var.tag
  public_subnets_cidr  = var.pub_cidr_subnet
  private_subnets_cidr = var.pri_cidr_subnet
}