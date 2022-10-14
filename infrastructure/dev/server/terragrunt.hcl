include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  merge_strategy = "deep"
  expose         = true
}

include "app" {
  path           = "${get_repo_root()}/infrastructure/_apps/server.hcl"
  merge_strategy = "deep"
}

include "server_deps" {
  path           = "${get_repo_root()}/infrastructure/_deps/server.hcl"
  merge_strategy = "deep"
}

locals {
  env = include.env.locals.env
}

inputs = {
  ecs_container = {
    image_tag = local.env
  }

  ecs_task = {
    cpu    = 256
    memory = 512
  }

  ecs_service = {
    desired_count        = 3
    force_new_deployment = true
  }
}
