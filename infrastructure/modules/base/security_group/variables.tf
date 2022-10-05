variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "vpc_id" {
  type = string
}

variable "ingress" {
  type = list(object({
    port             = optional(number)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    security_groups  = optional(list(string))
  }))
}

variable "egress" {
  type = list(object({
    port             = optional(number)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
  }))
  default = [
    {
      port             = 0
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}

variable "tags" {
  type    = map(any)
  default = {}
}
