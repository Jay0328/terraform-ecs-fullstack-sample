locals {
  repository_name = var.repository_name_prefix != null ? "${var.repository_name_prefix}${var.repository_name}" : var.repository_name
}

module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                   = local.repository_name
  repository_read_write_access_arns = var.repository_read_write_access_arns
  repository_lifecycle_policy = var.repository_lifecycle_policy

  tags = var.tags
}
