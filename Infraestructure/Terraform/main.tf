provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = var.region
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true

  endpoints {
    apigateway = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    dynamodb   = "http://localhost:4566"
    events     = "http://localhost:4566"
    iam        = "http://localhost:4566"
    sts        = "http://localhost:4566"
    s3         = "http://localhost:4566"
  }
}

module "dynamo_db" {
  source = "./modules/dynamo_db"

  infra_env = var.infra_env
}

module "lambda_functions" {
  source = "./modules/lambda_functions"

  infra_env = var.infra_env
  region = var.region
  scheduled_tasks_table_arn = module.dynamo_db.scheduled_tasks_table_arn
  scheduled_tasks_table_name = module.dynamo_db.scheduled_tasks_table_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  infra_env = var.infra_env
  create_scheduled_task_name = module.lambda_functions.create_scheduled_task_name
  create_scheduled_task_invoke_arn = module.lambda_functions.create_scheduled_task_invoke_arn
  list_scheduled_task_name = module.lambda_functions.list_scheduled_task_name
  list_scheduled_task_invoke_arn = module.lambda_functions.list_scheduled_task_invoke_arn
}