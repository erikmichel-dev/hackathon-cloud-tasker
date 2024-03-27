resource "aws_api_gateway_rest_api" "this" {
  name        = "TaskAPI"
  description = "Main API for TaskAPI"
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name        = "TaskAPI"
    Project     = var.project_name
    Environment = var.infra_env
  }
}

resource "aws_api_gateway_resource" "createtask" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "createtask"
}

resource "aws_api_gateway_resource" "listtask" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "listtask"
}

resource "aws_api_gateway_method" "createtask" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.createtask.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "listtask" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.listtask.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "createtask" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_method.createtask.resource_id
  http_method = aws_api_gateway_method.createtask.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.create_scheduled_task_invoke_arn
}

resource "aws_api_gateway_integration" "listtask" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_method.listtask.resource_id
  http_method = aws_api_gateway_method.listtask.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.list_scheduled_task_invoke_arn
}

resource "aws_lambda_permission" "apigw_create_scheduled_task" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.create_scheduled_task_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "apigw_list_scheduled_task" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.list_scheduled_task_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [
    aws_api_gateway_integration.createtask,
    aws_api_gateway_integration.listtask
  ]

  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.infra_env

  lifecycle {
    create_before_destroy = true
  }
}
