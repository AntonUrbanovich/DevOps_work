variable "private_subnet_b" {
  type = string
  description = "It is subnet where will install container"
}

variable "security_group_id_vpc" {
  type = string
  description = "for use sg in ecs"
}

variable "target_group_alb" { 
  type = string
  description = "for alb"
}