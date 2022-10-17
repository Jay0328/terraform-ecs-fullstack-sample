output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3.domain_name
}

output "url" {
  value = aws_route53_record.website_cname.fqdn
}
