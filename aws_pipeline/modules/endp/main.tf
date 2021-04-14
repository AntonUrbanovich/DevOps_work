resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.aws_route_tables]
 

  tags = {
    Name        = "s3-endpoint"
    Environment = "dev"
  }
}

resource "aws_vpc_endpoint" "dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.us-east-2.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [
   var.security_group_id_vpc
  ]
  subnet_ids = [var.private_subnet_b]

  tags = {
    Name        = "dkr-endpoint"
    Environment = "dev"
  }
}