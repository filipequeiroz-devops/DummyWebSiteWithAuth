resource "aws_dynamodb_table" "users_table" {
  name         = "UsersProfile-${var.environment}"
  billing_mode = "PAY_PER_REQUEST" # Custo zero se não houver uso
  hash_key     = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    Project     = "AuthSystem"
    Environment = var.environment
  }
}