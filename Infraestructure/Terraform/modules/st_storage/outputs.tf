output "scheduled_tasks_table_name" {
  value = aws_dynamodb_table.scheduled_tasks.name
}

output "scheduled_tasks_table_arn" {
  value = aws_dynamodb_table.scheduled_tasks.arn
}

output "scheduled_tasks_bucket_id" {
  value = aws_s3_bucket.scheduled_tasks.id
}

output "scheduled_tasks_bucket_arn" {
  value = aws_s3_bucket.scheduled_tasks.arn
}
