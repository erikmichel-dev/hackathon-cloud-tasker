variable "infra_env" {
  type        = string
  description = "Current environment"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "Region used"
}

variable "scheduled_tasks_table_name" {
  type        = string
  description = "Dynamodb scheduled tasks table name"
}

variable "scheduled_tasks_table_arn" {
  type        = string
  description = "Dynamodb scheduled tasks table arn"
}

variable "scheduled_tasks_bucket_arn" {
  type        = string
  description = "S3 scheduled tasks bucket arn"
}

variable "scheduled_tasks_bucket_id" {
  type        = string
  description = "S3 scheduled tasks bucket id"
}
