variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "app" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "subdomain_prefix" {
  type = string
}

variable "network" {
  type = object({
    vpc_id          = string
    vpc_cidr_block  = string
    public_subnets  = set(string)
    private_subnets = set(string)

    alb_security_group_id = string
  })
}

variable "alb" {
  type = object({
    internal = bool
    health_check = object({
      path = string
      port = optional(number, null)
    })
    https_certificate_arn = optional(string, null)

    enable_http2 = optional(bool, false)
  })
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_container" {
  type = object({
    image_repository = string
    image_tag        = string
    port             = number
  })
}

variable "ecs_task" {
  type = object({
    network_mode             = string
    requires_compatibilities = set(string)
    cpu                      = number
    memory                   = number
  })
}

variable "ecs_service" {
  type = object({
    launch_type          = string
    desired_count        = number
    force_new_deployment = bool
  })
}

variable "tags" {
  type    = map(any)
  default = {}
}
