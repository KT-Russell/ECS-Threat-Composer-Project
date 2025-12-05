variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "ecs_execution_role_name" {
  type        = string
  description = "Name of ECS execution role"
}

variable "ecs_task_role_name" {
  type        = string
  description = "ECS Task role name"
}

variable "ecs_assume_service" {
  type        = string
  description = "ecs assume service"
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
}

variable "cluster_insight_name" {
  description = "Name of the ECS cluster setting"
  type        = string
}
variable "cluster_insight_value" {
  type        = string
  description = "Value of ECS Cluster settings"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  type = number
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "task_family" {
  description = "Family name for ECS task definition"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
}

variable "task_memory" {
  description = "Memory for the task"
  type        = string
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
}

variable "target_type" {
  type = string
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "health_check_path" {
  type = string
}

variable "availability_zones" {
  type = list(string)
  default = [ "eu-west-2a", "eu-west-2b" ]
}

variable "alb_name" {
  type = string
  default = "threat-mod-alb"
}