output "s3_bucket_name" {
  description = "O nome do bucket S3 usado para armazenar o estado do Terraform."
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "s3_bucket_arn" {
  description = "O ARN do bucket S3 usado para armazenar o estado do Terraform."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "mysqldb_endpoint" {
  description = "O endpoint MySqlDB usado para o bloqueio de estado do Terraform."
  value = aws_db_instance.mysqldb_instance.endpoint
}

output "mysqldb_identifier" {
  description = "O nome da instancia MySqlDB usado para o bloqueio de estado do Terraform."
  value = aws_db_instance.mysqldb_instance.identifier
}
