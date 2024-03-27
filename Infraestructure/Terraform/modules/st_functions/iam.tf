resource "aws_iam_role" "st_create" {
  name               = "lambda_create_scheduled_task_role-${var.infra_env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "st_list" {
  name               = "lambda_list_scheduled_task_role-${var.infra_env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "st_execute" {
  name               = "lambda_execute_scheduled_task_role-${var.infra_env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "st_create_cloudwatch_logs" {
  role       = aws_iam_role.st_create.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}
resource "aws_iam_role_policy_attachment" "st_create_dynamodb" {
  role       = aws_iam_role.st_create.name
  policy_arn = aws_iam_policy.st_create_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "st_list_cloudwatch_logs" {
  role       = aws_iam_role.st_list.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}
resource "aws_iam_role_policy_attachment" "st_list_dynamodb" {
  role       = aws_iam_role.st_list.name
  policy_arn = aws_iam_policy.st_list_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "st_execute_cloudwatch_logs" {
  role       = aws_iam_role.st_execute.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}
resource "aws_iam_role_policy_attachment" "st_execute_bucket" {
  role       = aws_iam_role.st_execute.name
  policy_arn = aws_iam_policy.st_execute_bucket.arn
}

resource "aws_iam_policy" "cloudwatch_logs" {
  name        = "cloudwatch_logs_policy-${var.infra_env}"
  path        = "/"
  description = "AWS IAM Policy for cloudwatch logs access"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "st_create_dynamodb" {

  name        = "lambda_create_scheduled_task-${var.infra_env}"
  path        = "/"
  description = "AWS IAM Policy for create_scheduled_task lambda role"
  policy      = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "dynamodb:PutItem",
			"Resource": [
        "${var.scheduled_tasks_table_arn}"
        ],
			"Effect": "Allow"
		}
	]
}
EOF
}

resource "aws_iam_policy" "st_list_dynamodb" {

  name        = "lambda_list_scheduled_task-${var.infra_env}"
  path        = "/"
  description = "AWS IAM Policy for create_scheduled_task lambda role"
  policy      = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "dynamodb:Scan",
			"Resource": [
        "${var.scheduled_tasks_table_arn}"
        ],
			"Effect": "Allow"
		}
	]
}
EOF
}

resource "aws_iam_policy" "st_execute_bucket" {

  name        = "lambda_execute_scheduled_task-${var.infra_env}"
  path        = "/"
  description = "AWS IAM Policy for create_scheduled_task lambda role"
  policy      = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "s3:PutObject",
			"Resource": [
        "${var.scheduled_tasks_bucket_arn}/*"
        ],
			"Effect": "Allow"
		}
	]
}
EOF
}
