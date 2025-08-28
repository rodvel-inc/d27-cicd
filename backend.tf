terraform {
  backend "s3" {
    bucket = "terraform-state-roxs"
    key    = "roxs-voting-app/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "http://localhost:4566"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }

}