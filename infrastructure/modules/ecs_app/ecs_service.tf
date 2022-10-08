resource "aws_ecs_service" "this" {
  name                              = local.ecs_service_name
  cluster                           = var.ecs_cluster_name
  task_definition                   = aws_ecs_task_definition.this.arn
  launch_type                       = var.ecs_service.launch_type
  desired_count                     = var.ecs_service.desired_count
  health_check_grace_period_seconds = 10

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_security_group.id]
    subnets          = var.network.private_subnets
  }

  load_balancer {
    target_group_arn = module.alb.target_group.arn
    container_name   = local.name
    container_port   = var.ecs_container.port
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }

  tags = local.ecs_service_tags
}

resource "aws_security_group" "ecs_security_group" {
  name   = local.ecs_security_group_name
  vpc_id = var.network.vpc_id

  ingress {
    protocol        = "TCP"
    from_port       = var.ecs_container.port
    to_port         = var.ecs_container.port
    cidr_blocks     = [var.network.vpc_cidr_block]
    security_groups = [var.network.alb_security_group_id]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.ecs_security_group_tags
}
