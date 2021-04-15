variable "environment" {
type = string
description = "the name of one of two values for name vpc"
default = "dev"
}

variable "project" {
  type = string
  description = "the name of one of two values for name vpc"
  default = "youtube"
}

variable "vpc_cidr_block" {
  type = map(string)
  description = "some values for cidr_blocks of subnets"
  default = {
  for_vpc   = "10.0.0.0/20"
  for_pub_a = "10.0.0.0/22" 
  for_pub_b = "10.0.4.0/22"
  for_pri_a = "10.0.8.0/22"
  for_pri_b = "10.0.12.0/22"
  }
}


