    provider "aws" {
      region = "us-east-2"   
    }


    module "s3_static_website" {
      source = "/mnt/c/terraform-s3-website/modules/s3-website"
      bucket_name = var.bucket_name
    }

    