data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project}-${var.env}"
  cidr = var.vpc.cidr

  azs             = [for suffix in var.vpc.azs_suffixes : "${data.aws_region.current.name}${suffix}"]
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets

  enable_ipv6          = var.vpc.enable_ipv6
  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  enable_dns_support   = var.vpc.enable_dns_support
  enable_nat_gateway   = var.vpc.enable_nat_gateway
  enable_vpn_gateway   = var.vpc.enable_vpn_gateway

  tags = var.tags
}
