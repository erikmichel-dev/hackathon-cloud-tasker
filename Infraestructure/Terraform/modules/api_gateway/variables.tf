variable "infra_env" {
  type        = string
  description = "Current environment"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "create_scheduled_task_name" {
  type        = string
  description = "CreateScheduledTask lambda name"
}

variable "create_scheduled_task_invoke_arn" {
  type        = string
  description = "CreateScheduledTask lambda invoke arn"
}

variable "list_scheduled_task_name" {
  type        = string
  description = "ListScheduledTask lambda name"
}

variable "list_scheduled_task_invoke_arn" {
  type        = string
  description = "ListScheduledTask lambda invoke arn"
}
