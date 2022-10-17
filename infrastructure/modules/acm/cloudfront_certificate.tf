provider "aws" {
  alias  = "cloudfront_acm"
  region = "us-east-1"
}

data "aws_acm_certificate" "cloudfront" {
  provider = aws.cloudfront_acm
  domain   = var.domain_name
}
