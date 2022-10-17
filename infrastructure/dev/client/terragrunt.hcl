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
  path           = "${get_repo_root()}/infrastructure/_apps/client.hcl"
  merge_strategy = "deep"
}

include "client_deps" {
  path           = "${get_repo_root()}/infrastructure/_deps/client.hcl"
  merge_strategy = "deep"
}

locals {
  env = include.env.locals.env
}

inputs = {
}
