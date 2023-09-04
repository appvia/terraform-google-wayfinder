domainFilters:
  - external-dns-test.gcp.wayfinder
txtOwnerId: external-dns
# GKE cluster and CloudDNS must be in same project
provider: google
rbac:
  create: true
  apiVersion: v1
# Set to 'upsert-only' for updates, 'sync' to alow deletes
# Issue: sync seems to cause records to continually create/delete
policy: upsert-only
serviceAccount:
  annotations:
    iam.gke.io/gcp-service-account: "cloud-dns@${project_id}.iam.gserviceaccount.com"
  name: external-dns