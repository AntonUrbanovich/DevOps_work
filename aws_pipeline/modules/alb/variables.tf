variable "private_subnet_b" {
  type        = string
  description = "Thus subnet for install container"
}

variable "public_subnet_a" {
  type = string
  description = "This subnet for alb "
}

variable "security_group_id_vpc" {
  type        = string
  description = "for use sg in ecs"
}

variable "vpc_for_alb" {
  type        = string 
  description = "this value for assignment vpc to alb"
}