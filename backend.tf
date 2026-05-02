terraform {
  backend "s3" {
    bucket         = "stanley-terraform-state-bucket"
    key            = "three-tier/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true
    encrypt        = true
  }
}
