terraform {
  backend "remote" {
    organization = ""

    workspaces {}
  }
}

provider "aws" {
  region = var.aws_region
}
