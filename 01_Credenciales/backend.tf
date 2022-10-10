provider "aws" {
  region = "us-east-1"

}

terraform {
 backend "s3" {
   bucket = "tfstate-juan-trujillo"
   key    = "01_credenciales/tfstate-juan-trujillo"
   region = "us-east-1"
 }
}