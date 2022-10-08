locals {
  env = "dev"

  tags = {
    Environments = local.env
  }
}

inputs = {
  env = local.env
  
  tags = local.tags
}
