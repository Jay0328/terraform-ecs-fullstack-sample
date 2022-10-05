module "cluster" {
  source = "../../base/ecs_cluster"

  name = "${var.project}-${var.env}"

  tags = var.tags
}
