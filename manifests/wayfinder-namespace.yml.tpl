apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: ${namespace}
  name: ${namespace}
