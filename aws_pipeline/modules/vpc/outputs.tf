output "subnet_id" {
  value = aws_subnet.private_subnet_b.id
}

output "security_group_id" {
  value = aws_security_group.aws_security_group.id
}

output "subnet_id_a" {
  value = aws_subnet.public_subnet_a.id
}


output "aws_vpc" {
  value = aws_vpc.aws_vpc.id
}

output "aws_route_table" {
  value = aws_route_table.rtp2.id
}