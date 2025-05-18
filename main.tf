# Define a região da AWS onde os recursos serão criados
provider "aws" {
  region = var.aws_region
}

# Prefixo local para nomear os recursos e facilitar a identificação
locals {
  prefix = "fast-food-app"
}

# Bucket S3 para armazenar o estado do Terraform
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${local.prefix}-tfstate"
  force_destroy = true
  acl           = "private"
}

# Habilita o versionamento do Bucket S3 para manter um histórico dos estados do Terraform
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [aws_s3_bucket.s3_bucket]
}

# Aplica criptografia AES256 por padrão em todos os objetos do Bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_sse_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  depends_on = [aws_s3_bucket.s3_bucket]
}

# Tabela no MySqlDB para o bloqueio de estado do Terraform
resource "aws_mysqldb_table" "mysqldb_table" {
  name         = "${local.prefix}-tflocks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
