locals {
  env = "dev"

  tags = {
    Environment = local.env
  }
}

inputs = {
  env = local.env
  
  tags = local.tags
}
