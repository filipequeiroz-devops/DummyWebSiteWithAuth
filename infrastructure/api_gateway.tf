resource "aws_apigatewayv2_api" "lambda_cognito_api" {
  name          = "lambda-cognito-api-${var.environment}"
  protocol_type = "HTTP"

  # CORS CONFIG
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["content-type", "authorization"]
  }
}


resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id      = aws_apigatewayv2_api.lambda_cognito_api.id
  name        = "production" #I did not creates any test stage, so I will use production as default
  auto_deploy = true
}

# JWT configuration
resource "aws_apigatewayv2_authorizer" "cognito_auth" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [aws_cognito_user_pool_client.client.id]
    issuer   = "https://${aws_cognito_user_pool.pool.endpoint}"
  }
}

#Integrates API with lambda funcion that will process the signup request
resource "aws_apigatewayv2_integration" "lambda_integration_signup" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.process_users_signup.invoke_arn
}

#Integrates API with lambda funcion that will process the confirmation request
resource "aws_apigatewayv2_integration" "lambda_integration_confirm" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.process_users_confirmation.invoke_arn
}

#Integrates API with lambda funcion that will process the authorize request
resource "aws_apigatewayv2_integration" "lambda_integration_authorize" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.process_users_authorization.invoke_arn
}

#Integrates API with lambda funcion that will process the login request
resource "aws_apigatewayv2_integration" "lambda_integration_login" {
  api_id           = aws_apigatewayv2_api.lambda_cognito_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.process_users_login.invoke_arn
}




#signup > confirmation > authorize > Login

#Defining Routes
#Signup route
resource "aws_apigatewayv2_route" "lambda_route_signup" {
  api_id    = aws_apigatewayv2_api.lambda_cognito_api.id
  route_key = "POST /signup"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration_signup.id}"
}

#confirm route
resource "aws_apigatewayv2_route" "lambda_route_confirm" {
  api_id    = aws_apigatewayv2_api.lambda_cognito_api.id
  route_key = "POST /confirm"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration_confirm.id}"
}

#login route
resource "aws_apigatewayv2_route" "lambda_route_login" {
  api_id    = aws_apigatewayv2_api.lambda_cognito_api.id
  route_key = "POST /login"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration_login.id}"
}

#JWT protected route, only accessible with a valid token
resource "aws_apigatewayv2_route" "lambda_route_protected" {
  api_id             = aws_apigatewayv2_api.lambda_cognito_api.id
  route_key          = "GET /meu-perfil" 
  authorization_type = "JWT"             # binding authorizer to the route, so only requests with valid JWT token will be able to access this route
  authorizer_id      = aws_apigatewayv2_authorizer.cognito_auth.id

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration_authorize.id}"
}

#Permission to allow API Gateway to call Lambda signup function
resource "aws_lambda_permission" "api_gw_signup" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_users_signup.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_cognito_api.execution_arn}/*/*" #first /* means any stage, second /* means any route
  #so this permission allows API Gateway to call the Lambda function for any stage and any route, but since we only have one stage and two routes, it will work as expected 
}

#Permission to allow API Gateway to call Lambda confirmation function
resource "aws_lambda_permission" "api_gw_confirm" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_users_confirmation.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_cognito_api.execution_arn}/*/*"
}

#Permission to allow API Gateway to call Lambda login function
resource "aws_lambda_permission" "api_gw_login" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_users_login.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_cognito_api.execution_arn}/*/*"
}

#Permission to allow API Gateway to call Lambda authorize function
resource "aws_lambda_permission" "api_gw_authorize" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_users_authorization.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_cognito_api.execution_arn}/*/*"
}
