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

data "archive_file" "st_execute" {
  type             = "zip"
  source_file      = "./../lambda/executeScheduledTask.py"
  output_file_mode = "0666"
  output_path      = "./src/executeScheduledTask.zip"
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

resource "aws_lambda_function" "st_execute" {
  function_name = "executeScheduledTask-${var.infra_env}"

  filename         = data.archive_file.st_execute.output_path
  source_code_hash = data.archive_file.st_execute.output_base64sha256
  role             = aws_iam_role.st_execute.arn
  handler          = "executeScheduledTask.lambda_handler"
  runtime          = "python3.12"

  environment {
    variables = {
      SCHEDULED_TASK_BUCKET_NAME = var.scheduled_tasks_bucket_id
      REGION                     = var.region
    }
  }

  tags = {
    Name        = "executeScheduledTask"
    Project     = var.project_name
    Environment = var.infra_env
  }
}
