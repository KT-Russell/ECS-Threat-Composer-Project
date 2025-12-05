variable "domain_name" {
  type        = string
  description = "Primary domain for the certificate"
}

variable "alternative_names" {
  type    = list(string)
  default = []
}


variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID"
}

variable "cloudflare_api_token" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
