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
