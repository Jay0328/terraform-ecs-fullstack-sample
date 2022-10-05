locals {
  name = "${var.project}-${var.app}-${var.env}"

  alb_security_group_name  = "${var.project}-${var.app}-alb-${var.env}"
  ecs_security_group_name  = "${var.project}-${var.app}-ecs-${var.env}"
  vpce_security_group_name = "${var.project}-${var.app}-vpce-${var.env}"

  log_prefix = "ecs"
  log_name   = "/${local.log_prefix}/${local.name}"
}

data "aws_region" "current" {}
