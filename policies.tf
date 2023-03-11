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
