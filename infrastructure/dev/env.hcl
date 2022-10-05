locals {
  env = "dev"

  tags = {
    env = local.env
  }
}

inputs = {
  env = local.env
  
  tags = local.tags
}
