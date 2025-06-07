terraform {
  backend "s3" {
    bucket         = "kalan-tf-backend-state"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kalan-terraform-locks"
    encrypt        = true
  }
}