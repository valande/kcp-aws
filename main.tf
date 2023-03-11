resource "aws_s3_bucket" "valbucket" {
  bucket = var.bucket_s3
}

resource "aws_s3_bucket_policy" "valbucket_access_policy" {
  bucket = aws_s3_bucket.valbucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [ "s3:GetObject" ]
        Resource  = [ "${aws_s3_bucket.valbucket.arn}/*" ]
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "valbucket_website" {
  bucket = aws_s3_bucket.valbucket.id

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
  bucket = aws_s3_bucket.valbucket.bucket

  key    = "index.html"
  source = "htdocs/index.html"
  source_hash = filemd5("htdocs/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.valbucket.bucket

  key    = "error.html"
  source = "htdocs/error.html"
  source_hash = filemd5("htdocs/error.html")
  content_type = "text/html"
}
