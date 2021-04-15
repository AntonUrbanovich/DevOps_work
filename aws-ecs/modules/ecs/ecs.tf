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
    subnets          = [var.private_subnet_b]
    assign_public_ip = false # Providing our containers with public IPs
    security_groups  = [var.security_group_id_vpc]
  }
  
 load_balancer {
    target_group_arn = var.target_group_alb # Referencing our target group
    container_name   = aws_ecs_task_definition.service.id
    container_port   = 80 # Specifying the container port
  }
}
