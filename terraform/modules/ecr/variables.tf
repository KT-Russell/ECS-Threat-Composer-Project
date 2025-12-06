variable "ecr_name" {
  type = string
  default = "threat-mod-app"
}

variable "image_tag_mutability" {
  type = string
}

variable "scan_on_push" {
  type = string
}