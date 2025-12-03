variable "ecs_execution_role_name" {
  description = "Name of the ECS task execution IAM Role"
  type        = string
}

variable "ecs_assume_service" {
  description = "Service Principal that will assume the ECS IAM roles"
  type        = string
  default     = "ecs-tasks.amazonaws.com"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to IAM resources"
}

variable "ecs_task_role_name" {
  description = "Name of ECS task IAM Role"
  type        = string
}

variable "ssm_parameter_arn" {
  description = "ARN of the SSM parameter to allow GetParameter"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS KEY (if used)"
  type        = string
  default     = ""
}


