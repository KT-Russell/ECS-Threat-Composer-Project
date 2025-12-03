variable "vpc_cidr" {
  type        = string
  description = "CIDR Block for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZ available for subnet use"

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Must provide 2 availability zones "
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

