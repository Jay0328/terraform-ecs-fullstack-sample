include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "ecs_fargate_app_dependencies" {
  path           = "${get_terragrunt_dir()}/../../_dependencies/ecs_fargate_app.hcl"
  merge_strategy = "deep"
}

locals {
  generate = read_terragrunt_config(find_in_parent_folders("root.hcl")).generate

  env = include.env.locals.env
  app = "server"

  port = 3001

  tags = {
    app = local.app
  }
}

generate = local.generate

inputs = {
  app = local.app

  alb = {
    internal = false
    health_check = {
      path = "/health"
      port = local.port
    }
  }

  ecs_container = {
    image = "${dependency.ecr.outputs.wrapper[local.app].repository_url}:${local.env}"
    port  = local.port
  }

  ecs_task = {
    cpu    = 256
    memory = 512
  }

  ecs_service = {
    desired_count = 3
  }

  tags = local.tags
}
