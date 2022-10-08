include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = true
  merge_strategy = "deep"
}

locals {
  generate = read_terragrunt_config(find_in_parent_folders("root.hcl")).generate
}

generate = local.generate

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//ecr"
}

inputs = {
  apps = [
    "client",
    "server"
  ]

  untagged_expires_in_number = 7
  untagged_expires_in_unit   = "days"

  prod_tag_prefix_list = ["v"]
  prod_max_count       = 10

  non_prod_tag_prefix_list = [
    ["dev"],
    ["staging"],
    ["qa"]
  ]
}
