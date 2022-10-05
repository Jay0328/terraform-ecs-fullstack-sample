variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "internal" {
  type    = bool
  default = false
}

variable "subnets" {
  type = set(string)
}

variable "health_check" {
  type = object({
    path = string
    port = number
  })
}

variable "https_certificate_arn" {
  type    = string
  default = null
}

variable "enable_http2" {
  type    = bool
  default = false
}

variable "security_group_name" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}
