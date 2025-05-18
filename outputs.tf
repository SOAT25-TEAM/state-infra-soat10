output "s3_bucket_name" {
  description = "O nome do bucket S3 usado para armazenar o estado do Terraform."
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "s3_bucket_arn" {
  description = "O ARN do bucket S3 usado para armazenar o estado do Terraform."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "dynamodb_table_name" {
  description = "O nome da tabela DynamoDB usada para o bloqueio de estado do Terraform."
  value       = aws_dynamodb_table.dynamodb_table.name
}

output "dynamodb_table_arn" {
  description = "O ARN da tabela DynamoDB usada para o bloqueio de estado do Terraform."
  value       = aws_dynamodb_table.dynamodb_table.arn
}
