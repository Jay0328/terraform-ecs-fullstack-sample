output "arn" {
  value = aws_alb.this.arn
}

output "dns_name" {
  value = aws_alb.this.dns_name
}

output "target_group" {
  value = aws_alb_target_group.this
}
