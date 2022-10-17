locals {
  enable_https = var.https_certificate_arn != null
  enable_http2 = local.enable_https && var.enable_http2
}

resource "aws_alb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups

  enable_http2 = local.enable_http2

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
  count = local.enable_https ? 0 : 1

  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_alb_listener" "http_redirect" {
  count = local.enable_https ? 1 : 0

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
  count = local.enable_https ? 1 : 0

  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.https_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}
