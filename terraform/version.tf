terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.60"
     }
  }

 backend "s3" {
    bucket = "agnello-dsouza-terraformstate"
    key    = "demo-env/infra/terraform.tfstate"
    region = "ap-south-1" 
 
    dynamodb_table = "demo-env-infra"    
  }  




}

provider "aws" {
  region = var.aws_region

}
