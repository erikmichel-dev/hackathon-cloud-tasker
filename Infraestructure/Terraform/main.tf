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

module "st_storage" {
  source = "./modules/st_storage"

  infra_env    = var.infra_env
  project_name = local.project_name
}

module "st_functions" {
  source = "./modules/st_functions"

  infra_env    = var.infra_env
  project_name = local.project_name

  region                      = var.region
  scheduled_tasks_table_name  = module.st_storage.scheduled_tasks_table_name
  scheduled_tasks_table_arn   = module.st_storage.scheduled_tasks_table_arn
  scheduled_tasks_bucket_name = module.st_storage.scheduled_tasks_s3_name
  scheduled_tasks_bucket_arn  = module.st_storage.scheduled_tasks_s3_arn
}

module "st_api" {
  source = "./modules/st_api"

  infra_env                   = var.infra_env
  project_name                = local.project_name
  st_create_lambda_name       = module.st_functions.st_create_lambda_name
  st_create_lambda_invoke_arn = module.st_functions.st_create_lambda_invoke_arn
  st_list_lambda_name         = module.st_functions.st_list_lambda_name
  st_list_lambda_invoke_arn   = module.st_functions.stst_list_lambda_invoke_arn
}

module "st_events" {
  source = "./modules/st_events"

  infra_env                    = var.infra_env
  project_name                 = local.project_name
  st_execute_lambda_name       = module.st_functions.execute_scheduled_task_invoke_arn
  st_execute_lambda_invoke_arn = module.st_functions.execute_scheduled_task_name
}
