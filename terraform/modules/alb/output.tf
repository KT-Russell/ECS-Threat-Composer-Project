output "alb_dns_name" {
  description = "DNS name of ALB"
  value = aws_lb.main.dns_name
}

output "alb_sg_id" {
  description = "Security group ID of the ALB"
  value = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  description = "target group ARN for ECS Service"
  value = aws_lb_target_group.tg.arn
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}
