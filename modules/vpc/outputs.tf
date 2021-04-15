output "subnet_id" {
  value = aws_subnet.private_subnet_a.id
}

output "security_group_id" {
  value = aws_security_group.aws_security_group.id
}

output "subnet_id_b" {
  value = aws_subnet.public_subnet_b.id
}


output "aws_vpc" {
  value = aws_vpc.aws_vpc.id
}