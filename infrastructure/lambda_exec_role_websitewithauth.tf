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

# Permission to write to DynamoDB and CloudWatch Logs
#Least privilege: only necessary actions are allowed, and only on the specific resources needed.
resource "aws_iam_role_policy" "dynamo_write_policy" {
  name = "lambda_dynamo_write_policy"
  role = aws_iam_role.lambda_exec_role_websitewithauth.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ]
      Effect   = "Allow"
      Resource = "${aws_dynamodb_table.users_table.arn}"
    },
    {
      #Allow lambda loggin
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}