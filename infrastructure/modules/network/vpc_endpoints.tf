module "vpce" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.vpce_security_group.id]

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
      policy = jsonencode({
        "Version" : "2008-10-17"
        "Statement" : [
          {
            "Sid" : "Access-to-specific-bucket-only",
            "Effect" : "Allow",
            "Principal" : "*",
            "Action" : "s3:GetObject",
            "Resource" : "arn:aws:s3:::prod-${data.aws_region.current.name}-starport-layer-bucket/*"
          }
        ]
      })
    }
    ssm = {
      service_name        = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
      service_type        = "Interface"
      private_dns_enabled = true
    }
  }

  tags = var.tags
}

resource "aws_security_group" "vpce_security_group" {
  name   = local.vpce_security_group_name
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow AWS Private Link"
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.vpce_security_group_tags
}
