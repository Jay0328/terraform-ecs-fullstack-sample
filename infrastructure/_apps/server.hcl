locals {
  app             = "server"
  port            = 3001
  subdomain_prefix = "api-test"

  tags = {
    App = local.app
  }
}

inputs = {
  app             = local.app
  port            = local.port
  subdomain_prefix = local.subdomain_prefix

  tags = local.tags
}
