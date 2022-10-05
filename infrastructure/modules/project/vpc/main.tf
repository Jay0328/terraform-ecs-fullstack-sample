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

module "vpce" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.vpce_security_group.id]

  endpoints = {
    ecr_api = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    ecr_dkr = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    logs = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
      service_type        = "Interface"
      private_dns_enabled = true
    }
    s3 = {
      service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
      service_type    = "Gateway"
      route_table_ids = module.vpc.private_route_table_ids
    }
    ssm = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
      service_type        = "Interface"
      private_dns_enabled = true
    }
  }

  tags = var.tags
}

module "vpce_security_group" {
  source = "../../base/security_group"

  name   = "${var.project}-vpce-${var.env}"
  vpc_id = module.vpc.vpc_id

  ingress = [
    {
      port        = 443
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  ]

  tags = var.tags
}
