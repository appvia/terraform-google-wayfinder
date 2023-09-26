output "cluster_endpoint" {
  description = "The endpoint for the Wayfinder GKE Kubernetes API."
  value       = "https://${google_container_cluster.gke.endpoint}"
}

output "cluster_ca_certificate" {
  description = "GKE cluster master endpoint CA certificate base64 encoded."
  value       = google_container_cluster.gke.master_auth[0].cluster_ca_certificate
}

output "wayfinder_service_account" {
  description = "The GCP service account for Wayfinder admin."
  value       = google_service_account.wayfinder.email
}

output "wayfinder_api_url" {
  description = "The URL for the Wayfinder API."
  value       = "https://${var.wayfinder_domain_name_api}"
}

output "wayfinder_ui_url" {
  description = "The URL for the Wayfinder UI."
  value       = "https://${var.wayfinder_domain_name_ui}"
}

output "wayfinder_instance_id" {
  description = "The unique identifier for the Wayfinder instance."
  value       = var.wayfinder_instance_id
}

output "wayfinder_admin_username" {
  description = "The username for the Wayfinder local admin user."
  value       = var.enable_k8s_resources && var.create_localadmin_user ? "localadmin" : null
}

output "wayfinder_admin_password" {
  description = "The password for the Wayfinder local admin user."
  value       = var.enable_k8s_resources && var.create_localadmin_user ? data.kubernetes_secret.localadmin_password[0].data["WF_LOCALADMIN_PASSWORD"] : null
  sensitive   = true
}
