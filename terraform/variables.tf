variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs"
  default = [ ["10.0.1.0/24", "10.0.2.0/24"] ]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "ecs_execution_role_name" {
  type        = string
  description = "Name of ECS execution role"
  default = "ecsExecutionRole"
}

variable "ecs_task_role_name" {
  type        = string
  description = "ECS Task role name"
  default = "ecsTaskRole"
}

variable "ecs_assume_service" {
  type        = string
  description = "ecs assume service"
  default = "ecs-tasks.amazonaws.com"
}

variable "ecr_name" {
  type    = string
  default = "threat-mod-app"
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "cluster_name" {
  type        = string
  description = "Name of ECS Cluster"
  default = "threat-mod-cluster"
}

variable "cluster_insight_name" {
  description = "Name of the ECS cluster setting"
  type        = string
  default = "containerInsights"
}
variable "cluster_insight_value" {
  type        = string
  description = "Value of ECS Cluster settings"
  default = "enabled"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default = "threat-mod-service"
}

variable "desired_count" {
  type = number
  default = 1
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default = "threat-mod-app"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default = 3000
}

variable "subnet_ids" {
  type = list(string)
  default = []
}

variable "security_group_ids" {
  type = list(string)
  default = [ ]
}

variable "task_family" {
  description = "Family name for ECS task definition"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
  default = "256"
}

variable "task_memory" {
  description = "Memory for the task"
  type        = string
  default = "512"
}

variable "image_url" {
  description = "Image URL in ECR"
  type        = string
}

variable "cloudflare_api_token" {
  type        = string
  description = "API token with DNS edit permissions"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID for kamranr.com"
}

variable "target_group_name" {
  type = string
  default = "threat-mod-tg"
}

variable "target_type" {
  type = string
  default = "ip"
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "health_check_path" {
  type = string
  default = "/health.json"
}

variable "availability_zones" {
  type = list(string)
  default = [ "eu-west-2a", "eu-west-2b" ]
}

variable "alb_name" {
  type = string
  default = "threat-mod-alb"
}