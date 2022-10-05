include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
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

dependency "ecr" {
  config_path = "${get_parent_terragrunt_dir("root")}/shared/ecr"
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("env")}/vpc"
}

dependency "ecs_cluster" {
  config_path = "${get_parent_terragrunt_dir("env")}/ecs_cluster"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//project/ecs_app"
}

inputs = {
  app = local.app

  vpc = dependency.vpc.outputs

  alb = {
    internal = false
    health_check = {
      path = "/health"
      port = local.port
    }
  }

  ecs_cluster_name = dependency.ecs_cluster.outputs.name

  ecs_container = {
    image = "${dependency.ecr.outputs.wrapper[local.app].repository_url}:${local.env}"
    port  = local.port
  }

  ecs_task = {
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
  }

  ecs_service = {
    launch_type   = "FARGATE"
    desired_count = 3
  }

  tags = local.tags
}
