resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  subnets            = var.public_subnets_ids
  security_groups    = [aws_security_group.alb_sg.id]
  load_balancer_type = "application"

  tags = {
    Enviroment = var.environment
    App        = var.alb_name
  }
}

# ALB Security Groups

resource "aws_security_group" "alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "SG for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.alb_name}-sg"
  }
}


# Target Group 

resource "aws_lb_target_group" "tg" {
  name        = var.target_group_name
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    matcher             = "200"
    interval            = "30"
    timeout             = "5"
    healthy_threshold   = "2"
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.alb_name}-tg"
    Environment = var.environment
  }
}

# ALB HTTP Listener 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
