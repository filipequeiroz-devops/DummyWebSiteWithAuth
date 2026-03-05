resource "aws_apigatewayv2_api" "lambda_cognito_api" {
  name          = "lambda-cognito-api-${var.environment}"
  protocol_type = "HTTP"

  # CORS CONFIG
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["content-type"]
  }
}


resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id      = aws_apigatewayv2_api.lambda_cognito_api.id
  name        = "production" #I did not creates any test stage, so I will use production as default
  auto_deploy = true
}

#Integrates API with lambda funcion
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.process_users_signup.invoke_arn
}

#Defining Routes
resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_cognito_api.id
  route_key = "POST /signup"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

#Permission to allow API Gateway to call Lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_users_signup.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_cognito_api.execution_arn}/*/*"
}

