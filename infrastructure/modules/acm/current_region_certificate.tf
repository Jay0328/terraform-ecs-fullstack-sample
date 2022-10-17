data "aws_acm_certificate" "current_region" {
  domain = "*.${var.domain_name}"
}
