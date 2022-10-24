variable "project" {
  type = string
}

variable "app" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

