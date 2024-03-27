output "st_create_lambda_name" {
  value = aws_lambda_function.st_create.function_name
}

output "st_create_lambda_invoke_arn" {
  value = aws_lambda_function.st_create.invoke_arn
}

output "st_list_lambda_name" {
  value = aws_lambda_function.st_list.function_name
}

output "st_list_lambda_invoke_arn" {
  value = aws_lambda_function.st_list.invoke_arn
}
