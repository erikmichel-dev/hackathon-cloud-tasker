provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
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