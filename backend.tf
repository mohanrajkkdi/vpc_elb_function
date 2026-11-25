terraform {
  backend "s3" {
    bucket = "vpc-lb-s3-fstate-backup"
    key = "dev/terraform.fstate"
    region = "us-west-2"
    encrypt = true
    use_lockfile = true
  }
}