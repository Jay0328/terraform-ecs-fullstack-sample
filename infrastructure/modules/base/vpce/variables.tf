variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_ids" {
  type = set(string)
}

variable "route_table_ids" {
  type = set(string)
}

variable "security_group_name" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}
