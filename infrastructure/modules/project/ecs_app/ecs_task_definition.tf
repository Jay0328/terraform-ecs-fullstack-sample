data "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.name
  network_mode             = var.ecs_task.network_mode
  requires_compatibilities = var.ecs_task.requires_compatibilities
  cpu                      = var.ecs_task.cpu
  memory                   = var.ecs_task.memory
  execution_role_arn       = data.aws_iam_role.ecs_execution.arn
  container_definitions = jsonencode([
    {
      name      = local.name
      image     = var.ecs_container.image
      cpu       = var.ecs_task.cpu
      memory    = var.ecs_task.memory
      essential = true
      portMappings = [
        {
          containerPort = var.ecs_container.port
          hostPort      = var.ecs_container.port
        }
      ]
      logConfiguration = {
        logDriver     = "awslogs"
        secretOptions = null
        options = {
          awslogs-group         = local.log_name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = local.log_prefix
        }
      }
    }
  ])

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "ecs_task" {
  name              = local.log_name
  retention_in_days = 30

  tags = var.tags
}
