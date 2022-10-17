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

variable "certificate_arn" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

