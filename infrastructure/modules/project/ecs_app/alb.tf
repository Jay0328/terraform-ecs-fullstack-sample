module "alb" {
  source = "../../base/alb"

  name                  = local.name
  vpc_id                = var.vpc.vpc_id
  internal              = var.alb.internal
  subnets               = var.vpc.public_subnets
  health_check          = var.alb.health_check
  https_certificate_arn = var.alb.https_certificate_arn

  enable_http2 = var.alb.enable_http2

  security_group_name = local.alb_security_group_name

  tags = var.tags
}
