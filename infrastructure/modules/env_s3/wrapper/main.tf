module "buckets" {
  source = "../"

  for_each = var.apps

  project = var.project
  app     = each.key

  tags = var.tags
}
