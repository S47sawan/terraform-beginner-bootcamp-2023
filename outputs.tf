#-----------------------------------------------------------------------------------------------------------------------------
#Create Outputs
#-----------------------------------------------------------------------------------------------------------------------------
output "bucket_name" {
  description = "Bucket name for static website hosting"
  value       = module.home_pacman_hosting.bucket_name
}
output "s3_website_endpoint" {
  description = "s3 static website hosting endpoint"
  value       = module.home_pacman_hosting.website_endpoint
}
output "domain_name" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_pacman_hosting.domain_name
}