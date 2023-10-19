output "service_account_email" {
  description = "The email of the created service account"
  value       = google_service_account.cloudidentity.email
}

output "service_account_id" {
  description = "The id of the created service account"
  value       = google_service_account.cloudidentity.id
}

output "service_account_name" {
  description = "The name of the created service account"
  value       = google_service_account.cloudidentity.name
}

output "service_account_public_key" {
  description = "The public key associated with the created service account"
  value       = google_service_account_key.cloudidentity.public_key
}

output "service_account_private_key" {
  description = "The private key associated with the created service account"
  value       = google_service_account_key.cloudidentity.private_key
  sensitive   = true
}