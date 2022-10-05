module "wrapper" {
  source = "../"

  for_each = var.items

  repository_name                   = each.key
  repository_name_prefix            = try(each.value.repository_name_prefix, var.defaults.repository_name_prefix, null)
  repository_read_write_access_arns = try(each.value.repository_read_write_access_arns, var.defaults.repository_read_write_access_arns)

  repository_untagged_expires_in_number = try(each.value.repository_untagged_expires_in_number, var.defaults.repository_untagged_expires_in_number)
  repository_untagged_expires_in_unit   = try(each.value.repository_untagged_expires_in_unit, var.defaults.repository_untagged_expires_in_unit)

  repository_tag_prefix_list  = try(each.value.repository_tag_prefix_list, var.defaults.repository_tag_prefix_list)
  repository_tagged_max_count = try(each.value.repository_tagged_max_count, var.defaults.repository_tagged_max_count)

  tags = try(merge(var.defaults.tags, each.value.tags), var.defaults.tags, {})
}
