variable "alb_name" {
  type = string
  default = "threat-mod-alb"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB will be deployed"
}

variable "public_subnets_ids" {
  type        = list(string)
  description = "Public subnet IDs for ALB"
}

variable "health_check_path" {
  type        = string
  default     = "/health.json"
  description = "Target group Health check path"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "target_type" {
  type    = string
  default = "ip"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate - used for HTTPS"
  type        = string
}

variable "ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "SSL policy for https listener"
}

variable "target_group_name" {
  type = string
}