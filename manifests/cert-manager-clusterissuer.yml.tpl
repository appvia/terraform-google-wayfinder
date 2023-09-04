apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-stg
spec:
  acme:
    # The ACME production server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: ${email}
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-stg
    solvers:
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: ${project_id}
