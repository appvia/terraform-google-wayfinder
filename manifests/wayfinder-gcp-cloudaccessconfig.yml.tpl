apiVersion: cloudaccess.appvia.io/v2beta2
kind: CloudAccessConfig
metadata:
  name: ${name}
  namespace: ws-admin
spec:
  cloud: gcp
  gcp:
    project: "${project_id}"
  description: ${description}
  type: ${type}
  cloudIdentityRef:
    cloud: gcp
    name: ${identity}
  permissions:
  - permission: ${permission}
    gcpServiceAccount: ${gcp_service_account}