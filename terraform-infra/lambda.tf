############################################
# Lambda function
############################################

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.project_name}-lambda-function"
  description   = "Lambda function that retrieves resume data from dynamodb table and returns response as json"
  handler       = "app.lambda_handler"
  runtime       = "python3.12"

  source_path = "./src/"

  attach_policies    = true
  policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  number_of_policies = 1

  attach_policy_statements = true
  policy_statements = {

    dynamo_db = {
      effect = "Allow"
      actions = [
        "dynamodb:GetItem"
      ]
      resources = ["${aws_dynamodb_table.this.arn}"]
    }

  }

  environment_variables = {
    DYNAMO_DB_TABLE_NAME = "${var.dynamodb_table_name}"
  }

  tags = {
    Name = "${var.project_name}"
  }
}