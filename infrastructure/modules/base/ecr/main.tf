locals {
  repository_name = var.repository_name_prefix != null ? "${var.repository_name_prefix}${var.repository_name}" : var.repository_name
}

module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                   = local.repository_name
  repository_read_write_access_arns = var.repository_read_write_access_arns
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire images older than ${var.repository_untagged_expires_in_number} ${var.repository_untagged_expires_in_unit}",
        selection = {
          tagStatus   = "untagged",
          countType   = "sinceImagePushed",
          countNumber = var.repository_untagged_expires_in_number
          countUnit   = var.repository_untagged_expires_in_unit,
        },
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2,
        description  = "Keep last ${var.repository_tagged_max_count} images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = var.repository_tag_prefix_list,
          countType     = "imageCountMoreThan",
          countNumber   = var.repository_tagged_max_count
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = var.tags
}
