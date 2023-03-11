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
