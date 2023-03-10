terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.58.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "valbucket-valande" {
  bucket = "valbucket-valande-2023"
}

resource "aws_s3_bucket_policy" "valbucket-valande-policy" {
  bucket = aws_s3_bucket.valbucket-valande.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.valbucket-valande.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "valbucket-valande-website" {
  bucket = aws_s3_bucket.valbucket-valande.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      http_error_code_returned_equals = 404
    }
    redirect {
      replace_key_with = "error.html"
    }
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.valbucket-valande.bucket
  key    = "index.html"
  source = "htdocs/index.html"
  source_hash = filemd5("htdocs/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.valbucket-valande.bucket
  key    = "error.html"
  source = "htdocs/error.html"
  source_hash = filemd5("htdocs/error.html")
  content_type = "text/html"
}

output "s3_endpoint" {
  value = "${aws_s3_bucket.valbucket-valande.bucket_domain_name}/index.html"
}
