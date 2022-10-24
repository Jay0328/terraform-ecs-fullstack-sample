locals {
  name = "${var.project}-${var.app}-env"
  tags = merge(var.tags, {
    Name = local.name
  })
}

data "aws_caller_identity" "current" {}
