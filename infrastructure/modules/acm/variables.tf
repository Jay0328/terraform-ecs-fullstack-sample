variable "domain_name" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}
