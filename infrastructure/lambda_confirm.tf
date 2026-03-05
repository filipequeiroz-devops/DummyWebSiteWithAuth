#lambda for validating user confirmation and login
data "archive_file" "confirm_zip" {
  type        = "zip"
  source_dir  = "${path.module}/handler/confirm"
  output_path = "${path.module}/handler/lambda_confirm_payload.zip"
}

resource "aws_lambda_function" "process_users_confirmation" {
  filename      = data.archive_file.confirm_zip.output_path
  function_name = "process_users_confirmation"
  role          = aws_iam_role.lambda_exec_role_websitewithauth.arn
  handler       = "confirm_handler.lambda_handler" # inside zip file, search for o confirm_handler.py
  runtime       = "python3.11"

  source_code_hash = data.archive_file.confirm_zip.output_base64sha256

  environment {
    variables = {
      COGNITO_CLIENT_ID = aws_cognito_user_pool_client.client.id
    }
  }
}