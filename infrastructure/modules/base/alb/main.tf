locals {
  create_https_listener = var.https_certificate_arn != null
}

resource "aws_alb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [module.security_group.id]

  enable_http2 = var.enable_http2

  tags = var.tags
}

resource "aws_alb_target_group" "this" {
  name        = var.name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = var.health_check.path
    port                = var.health_check.port
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = var.tags
}

resource "aws_alb_listener" "http_forward" {
  count = local.create_https_listener ? 0 : 1

  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_alb_listener" "http_redirect" {
  count = local.create_https_listener ? 1 : 0

  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  count = local.create_https_listener ? 1 : 0

  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_alb_listener_certificate" "https_certificate" {
  count = local.create_https_listener ? 1 : 0

  listener_arn    = aws_alb_listener.https[0].arn
  certificate_arn = var.https_certificate_arn
}

module "security_group" {
  source = "../security_group"

  name   = var.security_group_name
  vpc_id = var.vpc_id

  ingress = [
    {
      port             = 80
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      port             = 443
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = var.tags
}
