resource "aws_cloudfront_origin_access_identity" "s3" {
  comment = local.name
}

resource "aws_cloudfront_distribution" "s3" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [local.fqdn]

  origin {
    origin_id   = local.name
    domain_name = aws_s3_bucket.this.bucket_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.name
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 86400
    response_code         = 200
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  tags = local.tags
}

data "aws_iam_policy_document" "s3_cloudfront" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_cloudfront.json
}
