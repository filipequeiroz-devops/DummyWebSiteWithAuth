# Lambda identity
resource "aws_iam_role" "lambda_exec_role_websitewithauth" {
  name = "lambda_exec_role_websitewithauth"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "cognito_signup_policy" {
  name = "lambda_cognito_signup_policy"
  role = aws_iam_role.lambda_exec_role_websitewithauth.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cognito-idp:SignUp",        #Action that allows the Lambda function to sign up users in the Cognito User Pool
          "cognito-idp:ConfirmSignUp", #action that allows the Lambda function to confirm users in the Cognito User Pool
          "cognito-idp:InitiateAuth"   #action that allows the Lambda function to initiate the authentication flow in the Cognito User Pool, which is necessary for the login functionality
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      #allow logging to CloudWatch
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}