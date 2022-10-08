module "alb" {
  source = "../_base/alb"

  name                  = local.alb_name
  vpc_id                = var.network.vpc_id
  internal              = var.alb.internal
  subnets               = var.network.public_subnets
  security_groups       = [var.network.alb_security_group_id]
  health_check          = var.alb.health_check
  https_certificate_arn = var.alb.https_certificate_arn

  enable_http2 = var.alb.enable_http2

  tags = local.alb_tags
}
