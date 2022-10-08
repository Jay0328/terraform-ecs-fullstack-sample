locals {
  name = "${var.project}-${var.env}"
}

resource "aws_ecs_cluster" "this" {
  name = local.name

  tags = merge(var.tags, {
    Name = local.name
  })
}
