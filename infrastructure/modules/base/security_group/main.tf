resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress

    content {
      protocol         = "TCP"
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      security_groups  = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.egress

    content {
      protocol         = "-1"
      from_port        = egress.value.port
      to_port          = egress.value.port
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
    }
  }

  tags = var.tags
}
