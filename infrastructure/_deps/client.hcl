dependency "acm" {
  config_path = "${get_repo_root()}/infrastructure/shared/acm"
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
}

locals {
  app_config = read_terragrunt_config("${get_repo_root()}/infrastructure/_apps/client.hcl")

  app  = local.app_config.locals.app
}

terraform {
  source = "${get_repo_root()}/infrastructure/modules//web_s3_app"
}

inputs = {
  certificate_arn = dependency.acm.outputs.cloudfront_certificate_arn
}
