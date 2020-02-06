provider "aws" {
 region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "anandlavu"
    key    = "terraform/UAT/jenkins.tfstate"
    region = "ap-south-1"
  }
}

module "web-app-servers" {
source = "../../modules/webserver-ec2"
env = var.env
instance_count = var.instance_count
}
