data "archive_file" "st_create" {
  type             = "zip"
  source_file      = "./../lambda/createScheduledTask.py"
  output_file_mode = "0666"
  output_path      = "./src/createScheduledTask.zip"
}

data "archive_file" "st_list" {
  type             = "zip"
  source_file      = "./../lambda/listScheduledTask.py"
  output_file_mode = "0666"
  output_path      = "./src/listScheduledTask.zip"
}

resource "aws_lambda_function" "st_create" {
  function_name = "createScheduledTask-${var.infra_env}"

  filename         = data.archive_file.st_create.output_path
  source_code_hash = data.archive_file.st_create.output_base64sha256
  role             = aws_iam_role.st_create.arn
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

resource "aws_lambda_function" "st_list" {
  function_name = "listScheduledTask-${var.infra_env}"

  filename         = data.archive_file.st_list.output_path
  source_code_hash = data.archive_file.st_list.output_base64sha256
  role             = aws_iam_role.st_list.arn
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
