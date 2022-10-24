include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//env_s3/wrapper"
}

inputs = {
  apps = [
    "client",
    "server"
  ]
}
