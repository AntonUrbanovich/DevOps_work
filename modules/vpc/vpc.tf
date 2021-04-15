resource "aws_vpc" "aws_vpc" {
    cidr_block                          = var.vpc_cidr_block["for_vpc"]
    instance_tenancy                    = "default"
    
    tags = {
        Name = local.vpc_id
    }
}


resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.aws_vpc.id

    tags = {
        Name = "Internet-gateway"
    }
}

## Create subnet for aws_vpc

resource "aws_subnet" "public_subnet_a" {
    vpc_id                  = aws_vpc.aws_vpc.id
    cidr_block              = var.vpc_cidr_block["for_pub_a"]
    availability_zone       = "us-east-2a"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "Public_subnet_a"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id                  = aws_vpc.aws_vpc.id
    cidr_block              = var.vpc_cidr_block["for_pub_b"]
    availability_zone       = "us-east-2b"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "Public_subnet_b"
    }
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id                  = aws_vpc.aws_vpc.id  
    cidr_block              = var.vpc_cidr_block["for_pri_a"]
    availability_zone       = "us-east-2a"
    
    tags = {
        Name = "Private_subnet_a"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id                  = aws_vpc.aws_vpc.id
    cidr_block              = var.vpc_cidr_block["for_pri_b"]
    availability_zone       = "us-east-2b"
    
    tags = {
        Name = "Private_subnet_b"
    }
}

## Create route table and add association

resource "aws_default_route_table" "rtpub" {
    
    default_route_table_id = aws_vpc.aws_vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
        Name = "RTT"
    }
}

resource "aws_route_table" "rtp" {
    vpc_id = aws_vpc.aws_vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.aws_nat_gateway1.id
    }
        tags = {
            Name = "RT"
        }
}

resource "aws_route_table" "rtp2" {
    vpc_id = aws_vpc.aws_vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.aws_nat_gateway2.id
    }
        tags = {
            Name = "RT2"
        }
}        
resource "aws_route_table_association" "association" {
    subnet_id      = aws_subnet.public_subnet_a.id
    route_table_id = aws_default_route_table.rtpub.id
}

resource "aws_route_table_association" "association3" {
    subnet_id      = aws_subnet.public_subnet_b.id
    route_table_id = aws_default_route_table.rtpub.id
}

resource "aws_route_table_association" "association2" {
    subnet_id      = aws_subnet.private_subnet_a.id
    route_table_id = aws_route_table.rtp.id
}

resource "aws_route_table_association" "association4" {
    subnet_id      = aws_subnet.private_subnet_b.id
    route_table_id = aws_route_table.rtp2.id
}

## Create elastic ip
resource "aws_eip" "aws_eip" {
    vpc = true
    depends_on = [aws_internet_gateway.gw]

}

resource "aws_eip" "aws_eip2" {
    vpc = true
    depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "aws_nat_gateway1" {
    allocation_id = aws_eip.aws_eip.id
    subnet_id     = aws_subnet.public_subnet_a.id
    depends_on    = [aws_internet_gateway.gw]

    tags = {
        Name = "Nat_for_A"
    }
}

resource "aws_nat_gateway" "aws_nat_gateway2" {
    allocation_id = aws_eip.aws_eip2.id
    subnet_id     = aws_subnet.public_subnet_b.id
    depends_on    = [aws_internet_gateway.gw]
    
    tags = {
        Name = "Nat_for_B"
    }
}



## Create security group

resource "aws_security_group" "aws_security_group" {
    vpc_id = aws_vpc.aws_vpc.id
    lifecycle {
        create_before_destroy = true
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
