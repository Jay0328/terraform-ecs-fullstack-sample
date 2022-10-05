resource "aws_ecs_service" "this" {
  name                              = local.name
  cluster                           = var.ecs_cluster_name
  task_definition                   = aws_ecs_task_definition.this.arn
  launch_type                       = var.ecs_service.launch_type
  desired_count                     = var.ecs_service.desired_count
  health_check_grace_period_seconds = 10

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.ecs_security_group.id]
    subnets          = var.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = module.alb.target_group.arn
    container_name   = local.name
    container_port   = var.ecs_container.port
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }

  tags = var.tags
}

module "ecs_security_group" {
  source = "../../base/security_group"

  name   = local.ecs_security_group_name
  vpc_id = var.vpc.vpc_id

  ingress = [
    {
      port            = var.ecs_container.port
      cidr_blocks     = [var.vpc.vpc_cidr_block]
      security_groups = [module.alb.security_group.id]
    }
  ]

  tags = var.tags
}
