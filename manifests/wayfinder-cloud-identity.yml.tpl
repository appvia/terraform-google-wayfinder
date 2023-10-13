apiVersion: cloudaccess.appvia.io/v2beta2
kind: CloudIdentity
metadata:
  name: ${name}
  namespace: ws-admin
spec:
  cloud: gcp
  type: GCPWorkloadIdentity
  gcp:
    serviceAccount: ${implicit_identity_id}
