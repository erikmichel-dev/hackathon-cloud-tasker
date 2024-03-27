variable "infra_env" {
  type        = string
  description = "Current environment"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "st_execute_lambda_name" {
  type        = string
  description = "ExecuteScheduledTask lambda name"
}

variable "st_execute_lambda_arn" {
  type        = string
  description = "ExecuteScheduledTask lambda arn"
}
