module "repositories" {
  source = "../"

  for_each = var.repositories

  repository_name                   = each.key
  repository_name_prefix            = try(each.value.repository_name_prefix, var.defaults.repository_name_prefix, null)
  repository_read_write_access_arns = try(each.value.repository_read_write_access_arns, var.defaults.repository_read_write_access_arns)
  repository_image_tag_mutability   = try(each.value.repository_image_tag_mutability, var.defaults.repository_image_tag_mutability)
  repository_lifecycle_policy       = try(each.value.repository_lifecycle_policy, var.defaults.repository_lifecycle_policy, null)

  tags = try(merge(var.defaults.tags, each.value.tags), var.defaults.tags, {})
}
