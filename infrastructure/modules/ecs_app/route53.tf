data "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "alb_cname" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${local.subdomain}.${data.aws_route53_zone.main.name}"
  type    = "CNAME"
  ttl     = 300
  records = [module.alb.dns_name]
}
