output "ecs_execution_role_arn" {
  value       = aws_iam_role.ecs_execution.arn
  description = "ARN of the ECS execution role"
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task IAM role"
  value       = aws_iam_role.ecs_task.arn
}
