resource "aws_security_group" "service_security_group" {
  # name        = "ecs-security-group-${var.env}"
  # description = "ECS Security Group"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Only allowing traffic in from the load balancer security group
    security_groups = ["${aws_security_group.load_balancer.id}"]
  }

  egress {
    from_port   = 0             # Allowing any incoming port
    to_port     = 0             # Allowing any outgoing port
    protocol    = "-1"          # Allowing any outgoing protocol 
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
  }
}

resource "aws_ecs_cluster" "sre_bootcamp" {
  name = "sre-bootcamo-cluster-${var.env}"
}

resource "aws_cloudwatch_log_group" "sre_bootcamp" {
    name = "sre-bootcamp-log-group-${var.env}"
}

resource "aws_ecs_task_definition" "sre_bootcamp" {
  family                   = "sre-bootcamp-${var.env}"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "sre-bootcamp-${var.env}",
      "image": "${aws_ecr_repository.sre-bootcamp.repository_url}:${var.image_tag}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000
        }
      ],
      "memory": 512,
      "cpu": 256,
      "logConfiguration" : {
          "logDriver" : "awslogs",
          "options" : {
              "awslogs-group" : "${aws_cloudwatch_log_group.sre_bootcamp.name}",
              "awslogs-region" : "us-east-1",
              "awslogs-stream-prefix" : "sre-bootcamp"
          }
      }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-execution-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
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

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "sre_bootcamp_service" {
  name                 = "sre-bootcamp-service-${var.env}"        # Naming our first service
  cluster              = aws_ecs_cluster.sre_bootcamp.id          # Referencing our created Cluster
  task_definition      = aws_ecs_task_definition.sre_bootcamp.arn # Referencing the task our service will spin up
  launch_type          = "FARGATE"
  desired_count        = 1 # Setting the number of containers we want deployed to 3
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target.arn
    container_name   = aws_ecs_task_definition.sre_bootcamp.family
    container_port   = 8000 # Specifying the container port
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true # Providing our containers with public IPs
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}

