output "s3_endpoint" {
  description = "Amazon S3 static website endpoint"
  value = aws_s3_bucket_website_configuration.valbucket-website.website_endpoint
}
