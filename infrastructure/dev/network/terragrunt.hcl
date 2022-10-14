include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/modules//network"
}

inputs = {
  vpc = {
    cidr                 = "10.0.0.0/16"
    azs_suffixes         = ["a", "b", "c"],
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    enable_ipv6          = false
    enable_nat_gateway   = false
    enable_vpn_gateway   = false
    enable_dns_hostnames = true
    enable_dns_support   = true
  }
}
