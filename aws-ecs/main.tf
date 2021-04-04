provider "aws" {
    region  = "us-east-2"    
}
/*
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster" # Naming the cluster
}


resource "aws_ecs_task_definition" "service" {
  family                   = "service"
  container_definitions    = file("/mnt/c/terraform-ecs/task-definition/service.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256

}


resource "aws_ecs_service" "servie" {
  name            = "service"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.my_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.service.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 1 # Setting the number of containers we want deployed to 3


  network_configuration {
    subnets          = ["${aws_subnet.private_subnet_b.id}"]
    assign_public_ip = false # Providing our containers with public IPs
    security_groups  = ["${aws_security_group.aws_security_group.id}"]
  }
  
 load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our target group
    container_name   = aws_ecs_task_definition.service.id
    container_port   = 80 # Specifying the container port
  }
}



resource "aws_alb" "application_load_balancer" {
  name               = "test-lb-tf" # Naming our load balancer
  load_balancer_type = "application"

  subnets = [ # Referencing the default subnets
    "${aws_subnet.private_subnet_b.id}",
    "${aws_subnet.public_subnet_a.id}",
  ]
  # Referencing the security group
  security_groups = ["${aws_security_group.aws_security_group.id}"]
}

resource "aws_lb_target_group" "target_group" {
  name        = "target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${aws_vpc.aws_vpc.id}" # Referencing the default VPC
  health_check {
    matcher = "200,301,302"
    path    = "/"
  }
}

resource "aws_lb_listener" "listener" {

  load_balancer_arn = "${aws_alb.application_load_balancer.arn}" # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our tagrte group
  }
}

*/
module "vpc"{
  source = "./modules/vpc"
}

module "ecs"{
  source = "./modules/ecs"
  private_subnet_b = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  target_group_alb = module.alb.target_group
}

module "alb"{
  source                = "./modules/alb"
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  vpc_for_alb           = module.vpc.aws_vpc
  public_subnet_a       = module.vpc.subnet_id_a

}