output "create_scheduled_task_name" {
  value = aws_lambda_function.create_scheduled_task.function_name
}

output "create_scheduled_task_invoke_arn" {
  value = aws_lambda_function.create_scheduled_task.invoke_arn
}

output "list_scheduled_task_name" {
  value = aws_lambda_function.list_scheduled_task.function_name
}

output "list_scheduled_task_invoke_arn" {
  value = aws_lambda_function.list_scheduled_task.invoke_arn
}