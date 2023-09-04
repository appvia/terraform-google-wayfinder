api:
  gcp:
    wayfinderIamIdentity: "cloud-dns@${project_id}.iam.gserviceaccount.com"
  enabled: true
  endpoint:
    url: "https://${api_hostname}"
  ingress:
    enabled: true
    hostname: "${api_hostname}"
    tlsEnabled: true
    tlsSecret: "wayfinder-ingress-api-tls"
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-stg
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    namespace: "ingress-nginx"
    className: "nginx"
  wayfinderInstanceIdentifier: "${wayfinder_instance_identifier}"
  wfManagedWfCluster: true
mysql:
  pvc:
    storageClass: "${storage_class}"
ui:
  enabled: true
  endpoint:
    url: "https://${ui_hostname}"
  ingress:
    enabled: true
    hostname: "${ui_hostname}"
    tlsEnabled: true
    tlsSecret: "wayfinder-ingress-ui-tls"
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-stg
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
  name: external-dns
    namespace: "ingress-nginx"
    className: "nginx"