locals {
  untagged_lifecycle_policy_rule = {
    rulePriority = 1,
    description  = "Expire images older than ${var.untagged_expires_in_number} ${var.untagged_expires_in_unit}",
    selection = {
      tagStatus   = "untagged",
      countType   = "sinceImagePushed",
      countNumber = var.untagged_expires_in_number
      countUnit   = var.untagged_expires_in_unit,
    },
    action = {
      type = "expire"
    }
  }
  prod_lifecycle_policy_rule = {
    rulePriority = 2,
    description  = "Keep last ${var.prod_max_count} images on production",
    selection = {
      tagStatus     = "tagged",
      tagPrefixList = var.prod_tag_prefix_list,
      countType     = "imageCountMoreThan",
      countNumber   = var.prod_max_count
    },
    action = {
      type = "expire"
    }
  }
  non_prod_lifecycle_policy_rules = [
    for i, tag_prefix_list in var.non_prod_tag_prefix_list : {
      rulePriority = i + 3,
      description  = "Keep last 1 images on non production",
      selection = {
        tagStatus     = "tagged",
        tagPrefixList = tag_prefix_list,
        countType     = "imageCountMoreThan",
        countNumber   = 1
      },
      action = {
        type = "expire"
      }
    }
  ]
}

data "aws_caller_identity" "current" {}

module "ecr" {
  source = "../_base/ecr/wrapper"

  defaults = {
    repository_name_prefix            = "${var.project}-"
    repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
    repository_image_tag_mutability   = "MUTABLE"
    repository_lifecycle_policy = jsonencode({
      rules = concat(
        [
          local.untagged_lifecycle_policy_rule,
          local.prod_lifecycle_policy_rule
        ],
        local.non_prod_lifecycle_policy_rules
      )
    })

    tags = var.tags
  }

  repositories = {
    for app in var.apps : app => {
      tags = {
        App = app
      }
    }
  }
}
