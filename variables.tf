variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "MYSQL_USER" {
  description = "Usuário master do banco MySQL"
  type        = string
}

variable "MYSQL_PASSWORD" {
  description = "Senha do banco MySQL"
  type        = string
  sensitive   = true
}
