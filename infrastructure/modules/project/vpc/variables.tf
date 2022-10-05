variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "vpc" {
  type = object({
    cidr = string

    azs_suffixes    = set(string)
    private_subnets = list(string)
    public_subnets  = list(string)

    enable_ipv6          = bool
    enable_dns_hostnames = bool
    enable_dns_support   = bool
    enable_nat_gateway   = bool
    enable_vpn_gateway   = bool
  })
}
