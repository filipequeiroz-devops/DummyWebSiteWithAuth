data "archive_file" "lambda_zip_signup" {
  type        = "zip"
  source_dir  = "${path.module}/handler/signup" #for portability 
  output_path = "${path.module}/handler/lambda_signup_payload.zip"
}

resource "aws_lambda_function" "process_users_signup" {
  filename      = data.archive_file.lambda_zip_signup.output_path
  function_name = "process_users_signup"
  role          = aws_iam_role.lambda_exec_role_websitewithauth.arn
  handler       = "cognito_auth.lambda_handler" #inside de zip file, search for cognito_auth.py and then lambda_handler function
  runtime       = "python3.11"

  source_code_hash = data.archive_file.lambda_zip_signup.output_base64sha256

  environment {
    variables = {
      COGNITO_CLIENT_ID    = aws_cognito_user_pool_client.client.id
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.pool.id
    }
  }
}