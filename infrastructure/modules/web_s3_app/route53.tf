data "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "website_cname" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${local.subdomain}.${data.aws_route53_zone.main.name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.s3.domain_name]
}
