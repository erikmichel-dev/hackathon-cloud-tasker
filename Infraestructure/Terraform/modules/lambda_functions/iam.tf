resource "aws_iam_role" "create_scheduled_task" {
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

resource "aws_iam_role" "list_scheduled_task" {
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

resource "aws_iam_role_policy_attachment" "create_scheduled_task_cloudwatch_logs" {
  role       = aws_iam_role.create_scheduled_task.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}
resource "aws_iam_role_policy_attachment" "create_scheduled_task_dynamodb" {
  role       = aws_iam_role.create_scheduled_task.name
  policy_arn = aws_iam_policy.create_scheduled_task_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "list_scheduled_task_cloudwatch_logs" {
  role       = aws_iam_role.list_scheduled_task.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}
# resource "aws_iam_role_policy_attachment" "list_scheduled_task" {
#   role       = aws_iam_role.populate_coffee_pool.name
#   policy_arn = aws_iam_policy.batchwrite_coffee_pool.arn
# }

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

resource "aws_iam_policy" "create_scheduled_task_dynamodb" {

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