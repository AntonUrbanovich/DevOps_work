variable "ec2_instance_id" {
  description = "id for instance ec2"
  type = string

}

variable "private_subnet_a_id" {
  description = "the name of vpc private subnet a "
  type = string
}

variable "public_subnet_b_id" {
  description = "the name of vpc public subnet b "
  type = string
}

variable "vpc_security_group_id" {
  description = "the name of vpc security group"
  type = string
}

variable "aws_vpc" {
  description = "the name of vpc that we create"
  type = string 
}