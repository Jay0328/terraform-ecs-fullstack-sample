variable "repository_name" {
  type = string
}

variable "repository_name_prefix" {
  type    = string
  default = null
}

variable "repository_read_write_access_arns" {
  type = any
}

variable "repository_image_tag_mutability" {
  type = string
}

variable "repository_lifecycle_policy" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}
