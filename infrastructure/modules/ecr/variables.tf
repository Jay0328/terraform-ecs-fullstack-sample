variable "project" {
  type = string
}

variable "apps" {
  type = set(string)
}

variable "untagged_expires_in_number" {
  type = number
}

variable "untagged_expires_in_unit" {
  type = string
}

variable "prod_tag_prefix_list" {
  type = list(string)
}

variable "prod_max_count" {
  type = number
}

variable "non_prod_tag_prefix_list" {
  type = list(set(string))
}

variable "tags" {
  type    = map(any)
  default = {}
}
