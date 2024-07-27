
#######################################
# policy to allow apigateway invoke lambda function


module "apigateway_put_events_to_lambda_us_east_1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.0"

  create_role = true

  role_name         = "apigateway-put-events-to-lambda_us-east_1"
  role_requires_mfa = false

  trusted_role_services = ["apigateway.amazonaws.com"]

  custom_role_policy_arns = [
    module.apigateway_put_events_to_lambda_policy.arn
  ]
}

module "apigateway_put_events_to_lambda_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.0"

  name        = "apigateway-put-events-to-lambda"
  description = "Allow PutEvents to Lamda"

  policy = data.aws_iam_policy_document.apigateway_put_events_to_lambda_policy_doc.json
}


data "aws_iam_policy_document" "apigateway_put_events_to_lambda_policy_doc" {
  statement {
    sid       = "AllowInvokeFunction"
    actions   = ["lambda:InvokeFunction"]
    resources = ["*"]
  }
}