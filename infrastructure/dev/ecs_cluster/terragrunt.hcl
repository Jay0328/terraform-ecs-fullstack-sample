include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//ecs_cluster"
}
