installCRDs: true

serviceAccount:
  annotations:
    iam.gke.io/gcp-service-account: "cloud-dns@kore-demo.iam.gserviceaccount.com"

ingressShim:
  defaultIssuerName: letsencrypt-stg
  defaultIssuerKind: ClusterIssuer
  defaultIssuerGroup: cert-manager.io
