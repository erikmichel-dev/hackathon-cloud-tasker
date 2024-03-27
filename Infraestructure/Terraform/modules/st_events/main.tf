resource "aws_cloudwatch_event_rule" "every_minute" {
  name                = "every-minute"
  description         = "Executes \"ExecuteScheduledTask\" lambda function every minute"
  schedule_expression = "cron(0/1 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "every_minute" {
  rule      = aws_cloudwatch_event_rule.every_minute.name
  target_id = "executeScheduledTask-rule"
  arn       = var.st_execute_lambda_arn
}

resource "aws_lambda_permission" "st_event_rule_execute" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.st_execute_lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_minute.arn
}
