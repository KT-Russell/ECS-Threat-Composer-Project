data "aws_ecr_repository" "app" {
  name = var.ecr_name
}

resource "aws_ecs_cluster" "threat-mod" {
  name = var.cluster_name

  setting {
    name  = var.cluster_insight_name
    value = var.cluster_insight_value
  }
}

resource "aws_security_group" "ecs_service_sg" {
  name        = "ecs-service-sg"
  description = "SG for ECS Task"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow inbound ONLY from ALB SG"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.lb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.threat-mod.id
  task_definition = aws_ecs_task_definition.app-task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids         # list of subnet IDs
    security_groups  = var.security_group_ids # list of security group IDs
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}


resource "aws_ecs_task_definition" "app-task" {
  family                   = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_url
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group
          "awslogs-create-group"  = var.create_group
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.log_stream_prefix
        }
      }
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

