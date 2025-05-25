terraform {
  backend "s3" {
    bucket         = "my-web-app-tf-state"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-web-app"
    encrypt        = true
  }
}
