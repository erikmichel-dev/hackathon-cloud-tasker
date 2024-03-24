variable "infra_env" {
  type        = string
  description = "Current environment"
  default     = "prod"
}

variable "region" {
  type        = string
  description = "Region used"
  default     = "us-east-1"
}