terraform {
  backend "s3" {
    bucket = "sample-outputs-090922321"
    key    = "resume_challenge/terraform.tfstate"
    region = "us-east-1"
  }
}
