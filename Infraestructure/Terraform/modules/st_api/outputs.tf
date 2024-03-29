output "api_rest_api_id" {
  value = aws_api_gateway_deployment.this.rest_api_id
}

output "api_rest_invoke_url" {
  value = aws_api_gateway_deployment.this.invoke_url
}
