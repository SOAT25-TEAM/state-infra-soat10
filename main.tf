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
  identifier              = "${local.prefix}-mysql"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.default.name
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = var.security_group_ids
  storage_encrypted       = true
  deletion_protection     = false

  tags = {
    Name = "${local.prefix}-mysql-db"
  }
}
