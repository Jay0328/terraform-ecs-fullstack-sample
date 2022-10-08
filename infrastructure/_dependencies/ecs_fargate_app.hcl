dependency "ecr" {
  config_path = "../../shared/ecr"
}

dependency "network" {
  config_path = "../network"
}

dependency "ecs_cluster" {
  config_path = "../ecs_cluster"
}

terraform {
  source = "../../modules//ecs_app"
}

inputs = {
  network = dependency.network.outputs

  ecs_cluster_name = dependency.ecs_cluster.outputs.name

  ecs_task = {
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
  }

  ecs_service = {
    launch_type = "FARGATE"
  }
}
