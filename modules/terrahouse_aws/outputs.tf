#-----------------------------------------------------------------------------------------------------------------------------
#Create Outputs
#-----------------------------------------------------------------------------------------------------------------------------
output "bucket_name" {
  description = "Bucket name for static website hosting"
  value = aws_s3_bucket.website_bucket.bucket
}