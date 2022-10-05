data "aws_region" "current" {}

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = [module.security_group.id]

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
      route_table_ids = var.route_table_ids
    }
    ssm = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
      service_type        = "Interface"
      private_dns_enabled = true
    }
  }

  tags = var.tags
}

module "security_group" {
  source = "../security_group"

  name   = var.security_group_name
  vpc_id = var.vpc_id

  ingress = [
    {
      port        = 443
      cidr_blocks = [var.vpc_cidr_block]
    }
  ]

  tags = var.tags
}
