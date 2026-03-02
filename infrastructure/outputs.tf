output "name" {
  value       = aws_dynamodb_table.users_table.name
  description = "Nome da tabela DynamoDB de usuários"
}
