apiVersion: cloudaccess.appvia.io/v2beta1
kind: CloudIdentity
metadata:
  name: ${name}
  namespace: ws-admin
spec:
  cloud: gcp
  credentialsUpdated: "2023-01-01T00:00:00Z"
  implicitIdentity: true
  name: ${description}
  secretRef: {}