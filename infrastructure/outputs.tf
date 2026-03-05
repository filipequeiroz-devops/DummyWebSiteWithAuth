output "dynamodb-arn" {
  value       = aws_dynamodb_table.users_table.arn
  description = "ARN da tabela DynamoDB de usuários"
}

output "dynamodb-id" {
  value       = aws_dynamodb_table.users_table.id
  description = "ID da tabela DynamoDB de usuários"
}

output "dynamodb-name" {
  value       = aws_dynamodb_table.users_table.name
  description = "Nome da tabela DynamoDB de usuários"
}

output "user_pool_id" {
  value       = aws_cognito_user_pool.pool.id
  description = "O ID do User Pool para usar no código Python"
}

output "client_id" {
  value       = aws_cognito_user_pool_client.client.id
  description = "O ID do Client para o seu app_auth"
}


output "api_url" {
  value = "${aws_apigatewayv2_api.lambda_cognito_api.api_endpoint}/signup"
}