output "scheduled_tasks_table_name" {
  value = aws_dynamodb_table.scheduled_tasks.name
}

output "scheduled_tasks_table_arn" {
  value = aws_dynamodb_table.scheduled_tasks.arn
}