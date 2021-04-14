variable "vpc_id" {
  type = string 
  description = "vpc for endpoint"
}

variable "aws_route_tables" {
  type = string
  description = "route table for endpoint"
}
variable "private_subnet_b" {
  type = string
  description = "It is subnet where will install container"
}
variable "security_group_id_vpc" {
  type = string 
  description = "secirity group for endpoint"
}