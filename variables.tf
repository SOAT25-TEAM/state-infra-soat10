variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "Usuário master do banco MySQL"
  type        = string
}

variable "db_password" {
  description = "Senha do banco MySQL"
  type        = string
  sensitive   = true
}
