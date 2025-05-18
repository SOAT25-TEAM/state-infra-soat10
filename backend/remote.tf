terraform {
    backend "s3" {
    bucket         = "postech-10soat-grupo-47-tfstate"
    key            = "backend/state"
    region         = "us-east-1"
    mysqldb_table = "postech-10soat-grupo-47-tflocks"
    encrypt        = true
    }
}
