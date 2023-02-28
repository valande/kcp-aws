provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "valbucket-valande" {
  bucket = "nombre-del-bucket"
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

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.valbucket-valande.bucket
  key    = "index.html"
  source = "path/to/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.valbucket-valande.bucket
  key    = "error.html"
  source = "path/to/error.html"
  content_type = "text/html"
}

output "s3_endpoint" {
  value = aws_s3_bucket.valbucket-valande.bucket_domain_name
}
