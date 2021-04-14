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

variable "cluster_name" {
 type = string
 description = "name of some cluster"  
}

variable "service_name" {
  type = string 
  description = "name of some service"
}

variable "memory" {
  type = string 
  description = "value of memory"
}

variable "cpu" {
  type = string 
  description = "value of cpu"
}

variable "desired_count" {
  type = string
  description = "value of desired_count"
}

variable "container_port" {
  type = string
  description = "value of container_port"
}

variable "resource_name" {
  type = string 
  description = "names for different resources"
}
