terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#provider "aws" {
#  region = "us-east-1"
#}

#Here I tried provisioning in localstack, but the free license doesn't allow to create users pools, so I had to switch to AWS for testing. I left the code here for reference, but it is commented out to avoid confusion.
#provider "aws" {
#  region                      = "us-east-1"
#  access_key                  = "test" 
#  secret_key                  = "test"
#  skip_credentials_validation = true
#  skip_metadata_api_check     = true
#  skip_requesting_account_id  = true
#
#
#endpoints {
#    dynamodb        = "http://localhost:4566"
#    lambda          = "http://localhost:4566"
#    iam             = "http://localhost:4566"
#    cognitoidp      = "http://localhost:4566" #  User Pools
#    cognitoidentity = "http://localhost:4566" #  Identity Pools
#  }
#}