output "arn" {
  value = aws_alb.this.arn
}

output "url" {
  value = "http://${aws_alb.this.dns_name}"
}

output "target_group" {
  value = aws_alb_target_group.this
}

output "security_group" {
  value = module.security_group
}
