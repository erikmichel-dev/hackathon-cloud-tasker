### DynamoDB

resource "aws_dynamodb_table" "scheduled_tasks" {
  name         = "ScheduledTasks-${var.infra_env}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "task_id"

  global_secondary_index {
    name            = "TaskNameCronIndex"
    hash_key        = "task_name"
    range_key       = "cron_expression"
    projection_type = "ALL"
  }

  attribute {
    name = "task_name"
    type = "S"
  }

  attribute {
    name = "cron_expression"
    type = "S"
  }

  attribute {
    name = "task_id"
    type = "S"
  }

  tags = {
    Name        = "ScheduledTasks"
    Project     = var.project_name
    Environment = var.infra_env
  }
}


### S3_Buckets

# resource "random_id" "this" {
#   byte_length = 8
# }

resource "aws_s3_bucket" "scheduled_tasks" {
  bucket        = "taskstorage"
  force_destroy = true

  tags = {
    Name        = "ScheduledTasks"
    Project     = var.project_name
    Environment = var.infra_env
  }
}
