variable "infra_env" {
  description = "Current environment"
}

variable "create_scheduled_task_name" {
  description = "CreateScheduledTask lambda name"
}

variable "create_scheduled_task_invoke_arn" {
  description = "CreateScheduledTask lambda invoke arn"
}

variable "list_scheduled_task_name" {
  description = "ListScheduledTask lambda name"
}

variable "list_scheduled_task_invoke_arn" {
  description = "ListScheduledTask lambda invoke arn"
}