terraform {
  backend "s3" {
    bucket         = "bugraid-terraform-state-noufa-sunkesula"
    key            = "bugraid-assignment/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks-bugraid-noufa"
  }
}
