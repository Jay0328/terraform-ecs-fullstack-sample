dependency "ecr" {
  config_path = "../../shared/ecr"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "ecs_cluster" {
  config_path = "../ecs_cluster"
}

terraform {
  source = "../../modules//project/ecs_app"
}

inputs = {
  vpc = dependency.vpc.outputs

  ecs_cluster_name = dependency.ecs_cluster.outputs.name

  ecs_task = {
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
  }

  ecs_service = {
    launch_type = "FARGATE"
  }
}
