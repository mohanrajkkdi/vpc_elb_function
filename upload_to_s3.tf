resource "aws_s3_bucket_versioning" "enable_bucket_versioning" {
  bucket = "vpc-lb-s3-fstate-backup"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
  bucket = "vpc-lb-s3-fstate-backup"
  rule {
    id = "remove-noncurrent-versions"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class = "GLACIER"
    }

    status = "Enabled"
  }
}