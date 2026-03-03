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

