include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  generate = read_terragrunt_config(find_in_parent_folders("root.hcl")).generate

  project = include.root.locals.project

  tags = include.root.locals.tags
}

generate = local.generate

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules/base/ecr//wrapper"
}

inputs = {
  defaults = {
    repository_name_prefix            = "${local.project}-"
    repository_read_write_access_arns = [get_aws_caller_identity_arn()]

    repository_untagged_expires_in_number = 14
    repository_untagged_expires_in_unit   = "days"

    repository_tag_prefix_list  = ["v"]
    repository_tagged_max_count = 30

    tags = local.tags
  }

  items = {
    client = {
      tags = {
        app = "client"
      }
    }
    server = {
      tags = {
        app = "server"
      }
    }
  }
}
