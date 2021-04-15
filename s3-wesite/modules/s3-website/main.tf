provider "aws" {
    region  = "us-east-2"    
}

resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name
    acl = "public-read"
  

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}


resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "index.html"
  source = "/mnt/c/terraform-s3-website/html/index.html"
  content_type = "text/html"
  etag = filemd5("/mnt/c/terraform-s3-website/html/index.html")
  acl = "public-read"
}


resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "error.html"
  source = "/mnt/c/terraform-s3-website/html/error.html"
  content_type = "text/html"
  etag = filemd5("/mnt/c/terraform-s3-website/html/error.html")
  acl = "public-read"
}
