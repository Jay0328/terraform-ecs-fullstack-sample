locals {
  app             = "client"
  subdomain_prefix = "client-test"

  tags = {
    App = local.app
  }
}

inputs = {
  app             = local.app
  subdomain_prefix = local.subdomain_prefix

  tags = local.tags
}
