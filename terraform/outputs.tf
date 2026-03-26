output "instance_public_ip" {
  description = "The public IP address of your server"
  value       = aws_instance.webapp.public_ip
}

output "app_url" {
  description = "Your app URL"
  value       = "http://${aws_instance.webapp.public_ip}:3000"
}

output "s3_bucket_name" {
  description = "Name of the S3 storage bucket"
  value       = aws_s3_bucket.artifacts.bucket
}