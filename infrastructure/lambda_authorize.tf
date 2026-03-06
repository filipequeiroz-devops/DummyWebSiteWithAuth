data "archive_file" "authorize_zip" {
  type        = "zip"
  source_dir  = "${path.module}/handler/authorize"
  output_path = "${path.module}/handler/lambda_authorize_payload.zip"
}

resource "aws_lambda_function" "process_users_authorization" {
  filename      = data.archive_file.authorize_zip.output_path
  function_name = "process_users_authorization"
  role          = aws_iam_role.lambda_exec_role_websitewithauth.arn
  handler       = "authorize_handler.lambda_handler" # inside zip file, search for o authorize_handler.py
  runtime       = "python3.11"

  source_code_hash = data.archive_file.authorize_zip.output_base64sha256
}