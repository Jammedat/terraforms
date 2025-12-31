resource "aws_s3_bucket" "main" {
    bucket = "devops-s3-22891"
    tags = {
      Name = "devops-s3-22891"
    }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  
}

resource "aws_s3_bucket_acl" "main" {
    bucket = aws_s3_bucket.main.id
    acl = "private"
  
}