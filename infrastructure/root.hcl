locals {
  project = "just-test"

  terraform_version    = "=1.3.1"
  aws_provider_version = "=4.33.0"

  aws_region             = "ap-southeast-1"
  backend_bucket         = "${local.project}-terraform"
  backend_dynamodb_table = "${local.project}-terraform"

  tags = {
    project = local.project
  }
}

generate "version" {
  path      = "version.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${local.terraform_version}"
}
EOF
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${local.aws_provider_version}"
    }
  }
}

provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = local.backend_bucket
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     encrypt        = true
#     region         = local.aws_region
#     dynamodb_table = local.backend_dynamodb_table
#   }
#   generate = {
#     path = "backend.tf"
#     if_exists = "overwrite"
#   }
# }

inputs = {
  project = local.project

  tags = local.tags
}
