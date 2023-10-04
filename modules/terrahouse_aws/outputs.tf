#-----------------------------------------------------------------------------------------------------------------------------
#Create Outputs
#-----------------------------------------------------------------------------------------------------------------------------
output "bucket_name" {
  description = "Bucket name for static website hosting"
  value       = aws_s3_bucket.website_bucket.bucket
}
output "website_endpoint" {
  description = "s3 static website hosting endpoint"
  value       = aws_s3_bucket_website_configuration.configuration_bucket.website_endpoint
}
