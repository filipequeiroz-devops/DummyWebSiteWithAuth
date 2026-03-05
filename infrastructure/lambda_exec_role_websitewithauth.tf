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
        Action   = ["cognito-idp:SignUp"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}