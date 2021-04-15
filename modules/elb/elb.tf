resource "aws_security_group" "elb_http" {
  name        = "elb_http"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

resource "aws_elb" "my_load_balancer" {
    name            = "my-load-balancer-test"
    subnets         = [var.private_subnet_a_id, var.public_subnet_b_id]
    security_groups = [ var.vpc_security_group_id ]
    depends_on      = [
     var.aws_vpc
    ]

    listener{
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80 
        lb_protocol       = "http"

    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2 
        timeout             = 3
        target              = "HTTP:80/index.html"
        interval            = 30

    }

    instances                   = [var.ec2_instance_id]
    connection_draining         = true
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining_timeout = 400

    tags = {
    Name = "my-load-balancer-test"
  }

}
