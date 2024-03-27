data "archive_file" "create_scheduled_task" {
  type             = "zip"
  source_file      = "./../lambda/createScheduledTask.py"
  output_file_mode = "0666"
  output_path      = "./src/createScheduledTask.zip"
}

data "archive_file" "list_scheduled_task" {
  type             = "zip"
  source_file      = "./../lambda/listScheduledTask.py"
  output_file_mode = "0666"
  output_path      = "./src/listScheduledTask.zip"
}

resource "aws_lambda_function" "create_scheduled_task" {
  function_name = "createScheduledTask-${var.infra_env}"

  filename         = data.archive_file.create_scheduled_task.output_path
  source_code_hash = data.archive_file.create_scheduled_task.output_base64sha256
  role             = aws_iam_role.create_scheduled_task.arn
  handler          = "createScheduledTask.lambda_handler"
  runtime          = "python3.12"

  environment {
    variables = {
      SCHEDULED_TASK_TABLE_NAME = var.scheduled_tasks_table_name
      REGION                    = var.region
    }
  }

  tags = {
    Name        = "createScheduledTask"
    Project     = var.project_name
    Environment = var.infra_env
  }
}

resource "aws_lambda_function" "list_scheduled_task" {
  function_name = "listScheduledTask-${var.infra_env}"

  filename         = data.archive_file.list_scheduled_task.output_path
  source_code_hash = data.archive_file.list_scheduled_task.output_base64sha256
  role             = aws_iam_role.list_scheduled_task.arn
  handler          = "listScheduledTask.lambda_handler"
  runtime          = "python3.12"

  environment {
    variables = {
      SCHEDULED_TASK_TABLE_NAME = var.scheduled_tasks_table_name
      REGION                    = var.region
    }
  }

  tags = {
    Name        = "listScheduledTask"
    Project     = var.project_name
    Environment = var.infra_env
  }
}
