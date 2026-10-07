variable "site_name" {
  description = "The zone the record is in"
  default     = "lonkar.org"
  type        = string
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API Token"
  type        = string
  sensitive   = true
}
