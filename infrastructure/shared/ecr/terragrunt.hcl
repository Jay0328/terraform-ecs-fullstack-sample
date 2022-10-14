include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//ecr"
}

inputs = {
  apps = [
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
