resource "aws_ecs_cluster" "worker_cluster" {
  name = var.cluster_name  # Naming the cluster
}


resource "aws_ecs_task_definition" "cluster_task" {
  family                   = "service"
  container_definitions    = local.container_definitions
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn
}




data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name        = "AmazonECSTaskExecutionRolePolicy"
  path        = "/service-role/"
  description = "Provides access to other AWS service resources that are required to run Amazon ECS tasks"
  policy      = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
  }
  EOF
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = local.esc_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution_role_policy.arn
}

resource "aws_ecs_service" "service" {
  name            = var.service_name                          # Naming our first service
  cluster         = "${aws_ecs_cluster.worker_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.cluster_task.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = var.desired_count # Setting the number of containers we want deployed to 3


  network_configuration {
    subnets          = [var.private_subnet_b]
    assign_public_ip = false # Providing our containers with public IPs
    security_groups  = [var.security_group_id_vpc]
  }
  
 load_balancer {
    target_group_arn = var.target_group_alb # Referencing our target group
    container_name   = aws_ecs_task_definition.cluster_task.id
    container_port   = var.container_port # Specifying the container port
  }
}
