data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda" #for portability 
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "aws_lambda_function" "process_users_login" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "process_users_login"
  role          = aws_iam_role.lambda_exec_role_websitewithauth.arn
  handler       = "index.lambda_handler" #
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.users_table.name
    }
  }
}