locals {
  name = "${var.project}-${var.app}-${var.env}"
  tags = merge(var.tags, {
    Name = local.name
  })

  subdomain = "${var.subdomain_prefix}-${var.env}"
  fqdn      = "${local.subdomain}.${var.domain_name}"
}
