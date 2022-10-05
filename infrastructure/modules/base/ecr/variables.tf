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


variable "repository_untagged_expires_in_number" {
  type = number
}

variable "repository_untagged_expires_in_unit" {
  type = string
}

variable "repository_tag_prefix_list" {
  type = list(string)
}

variable "repository_tagged_max_count" {
  type = number
}

variable "tags" {
  type    = map(any)
  default = {}
}
