module "vpce" {
  source = "../../base/vpce"

  vpc_id          = var.vpc.vpc_id
  vpc_cidr_block  = var.vpc.vpc_cidr_block
  subnet_ids      = var.vpc.private_subnets
  route_table_ids = var.vpc.private_route_table_ids

  security_group_name = local.vpce_security_group_name

  tags = var.tags
}
