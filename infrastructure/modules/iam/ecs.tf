data "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRole"
}

output "ecs_task_execution_role_arn" {
  value = data.aws_iam_role.ecs_execution.arn
}
