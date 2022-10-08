locals {
  name = "${var.project}-${var.app}-${var.env}"
  tags = merge(var.tags, {
    Name = local.name
  })

  alb_name = local.name
  alb_tags = local.tags

  alb_security_group_name = "${var.project}-${var.app}-alb-${var.env}"

  ecs_service_name = local.name
  ecs_service_tags = local.tags

  ecs_security_group_name = "${var.project}-${var.app}-ecs-${var.env}"
  ecs_security_group_tags = merge(var.tags, {
    Name = local.ecs_security_group_name
  })

  ecs_log_prefix = "ecs"
  ecs_log_name   = "/${local.ecs_log_prefix}/${local.name}"
}

data "aws_region" "current" {}
