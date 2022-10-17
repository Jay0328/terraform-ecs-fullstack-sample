dependency "acm" {
  config_path = "${get_repo_root()}/infrastructure/shared/acm"
}

dependency "ecr" {
  config_path = "${get_repo_root()}/infrastructure/shared/ecr"
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
}

dependency "ecs_cluster" {
  config_path = "${get_terragrunt_dir()}/../ecs_cluster"
}

locals {
  app_config = read_terragrunt_config("${get_repo_root()}/infrastructure/_apps/server.hcl")

  app  = local.app_config.locals.app
  port = local.app_config.locals.port
}

terraform {
  source = "${get_repo_root()}/infrastructure/modules//ecs_app"
}

inputs = {
  network = dependency.network.outputs

  alb = {
    internal = false
    health_check = {
      path = "/health"
      port = local.port
    }
    https_certificate_arn = dependency.acm.outputs.current_region_certificate_arn
    enable_http2 = true
  }

  ecs_cluster_name = dependency.ecs_cluster.outputs.name

  ecs_container = {
    image_repository = dependency.ecr.outputs.repositories[local.app].repository_url
    port  = local.port
  }

  ecs_task = {
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
  }

  ecs_service = {
    launch_type = "FARGATE"
  }
}
