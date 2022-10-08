locals {
  name = "${var.project}-${var.env}"

  vpc_name = local.name
  vpc_tags = merge(var.tags, {
    Name = local.vpc_name
  })

  vpce_security_group_name = "${var.project}-vpce-${var.env}"
  vpce_security_group_tags = merge(var.tags, {
    Name = local.vpce_security_group_name
  })

  alb_security_group_name = "${var.project}-alb-${var.env}"
  alb_security_group_tags = merge(var.tags, {
    Name = local.alb_security_group_name
  })
}

data "aws_region" "current" {}
