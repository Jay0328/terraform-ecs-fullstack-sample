output "url" {
  value = aws_route53_record.alb_cname.name
}
