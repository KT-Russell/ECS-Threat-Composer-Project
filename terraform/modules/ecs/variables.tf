variable "cluster_name" {
  description = "ecs cluster name"
  type        = string
}

variable "cluster_insight_name" {
  description = "name of the cluster setting name"
  type        = string
}

variable "cluster_insight_value" {
  description = "value of ecs cluster settings"
  type        = string
}

variable "service_name" {
  description = "Name of ECS Service"
  type        = string
}

variable "desired_count" {
  description = "Number of desired ECS Task"
  type        = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "task_family" {
  description = "family name"
  type        = string
}

variable "task_cpu" {
  description = "cpu"
  type        = string
}

variable "task_memory" {
  description = "memory"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM ROLE arn"
  type        = string
}

variable "container_name" {
  type        = string
  description = "Name of the container"
  default     = "tm-app-container"
}

variable "container_port" {
  type = number
}

variable "image_url" {
  description = "URL of the image in ecr"
  type        = string
}

variable "lb_target_group_arn" {
  type = string
}

variable "log_group" {
  description = "CloudWatch log group for ECS Container"
  type        = string
  default     = "/ecs/threat-mod-app"
}

variable "create_group" {
  description = "Decides that ECS should auto-create the log group"
  type        = string
  default     = "true"
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "log_stream_prefix" {
  description = "Prefix for Cloudwatch log streams"
  type        = string
  default     = "ecs"
}

variable "lb_security_group_id" {
  type        = string
  description = "SG ID of the ALB, used to allow ALB to ECS Traffic"
}

variable "vpc_id" {
  type = string
}