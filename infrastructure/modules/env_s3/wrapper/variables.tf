variable "project" {
  type = string
}

variable "apps" {
  type = set(string)
}

variable "tags" {
  type    = map(any)
  default = {}
}

