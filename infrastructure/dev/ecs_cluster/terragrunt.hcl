include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  merge_strategy = "deep"
}

locals {
  generate = read_terragrunt_config(find_in_parent_folders("root.hcl")).generate
}

generate = local.generate

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//ecs_cluster"
}
