output "current_region_certificate_arn" {
  value = data.aws_acm_certificate.current_region.arn
}

output "cloudfront_certificate_arn" {
  value = data.aws_acm_certificate.cloudfront.arn
}
