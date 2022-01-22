terraform {
  backend "s3" {
    bucket = "terraform-backend-365101756910"
    key    = "eu-west-1/dev/web-app"
    region = "eu-west-1"
  }
}
