variable "infra_env" {
  type        = string
  description = "Current environment"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "st_create_lambda_name" {
  type        = string
  description = "CreateScheduledTask lambda name"
}

variable "st_create_lambda_invoke_arn" {
  type        = string
  description = "CreateScheduledTask lambda invoke arn"
}

variable "st_list_lambda_name" {
  type        = string
  description = "ListScheduledTask lambda name"
}

variable "st_list_lambda_invoke_arn" {
  type        = string
  description = "ListScheduledTask lambda invoke arn"
}
