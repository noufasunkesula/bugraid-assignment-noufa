resource "aws_s3_bucket" "bugraid_noufa_logs" {
  bucket = "bugraid-noufa-logs-bucket"

  tags = {
    Name        = "bugraid-noufa-logs"
    Environment = "bugraid-noufa"
    Project     = "bugraid-assignment"
  }
}

# Block public access (mandatory for logs)
resource "aws_s3_bucket_public_access_block" "bugraid_noufa_logs" {
  bucket = aws_s3_bucket.bugraid_noufa_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "bugraid_noufa_logs" {
  bucket = aws_s3_bucket.bugraid_noufa_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bugraid_noufa_logs" {
  bucket = aws_s3_bucket.bugraid_noufa_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
