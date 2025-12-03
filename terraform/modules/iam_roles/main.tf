resource "aws_iam_role" "ecs_execution" {
  name = var.ecs_execution_role_name
  
  lifecycle {
    create_before_destroy = true
  }
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect = "Allow"
        Principal = {
          Service = var.ecs_assume_service 
        },
        Action = "sts:AssumeRole"
        Sid    = ""
      }
    ]
  })

  tags = merge(var.tags, {
    Name = var.ecs_execution_role_name
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_execution_logs" {
  name = "ecs-execution-logs"
  role = aws_iam_role.ecs_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:DescriveLogGroups",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "ecs_task" {
  name = var.ecs_task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = var.ecs_assume_service
      }
    }]
  })
}

resource "aws_iam_role_policy" "ssm_kms_access" {
  count = var.ssm_parameter_arn != "" && var.kms_key_arn != "" ? 1 : 0
  name  = "ssm-kms-access"
  role  = aws_iam_role.ecs_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ssm:GetParameter"]
        Resource = var.ssm_parameter_arn
      },
      {
        Effect   = "Allow"
        Action   = ["kms:Decrypt"]
        Resource = var.kms_key_arn
      }
    ]
  })
}