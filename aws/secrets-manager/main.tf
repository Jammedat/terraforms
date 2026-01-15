resource "aws_secretsmanager_secret" "main" {
    name = "datacenter-secret"
  
}

variable "example" {
  default = {
    username = "admin"
    password = "Namin123"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(var.example)
}