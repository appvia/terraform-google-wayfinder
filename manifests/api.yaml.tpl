---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "wayfinder.name" . }}-apiserver
  {{- if .Values.api.endpoint.detect }}
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "0"
  {{- end }}
  labels:
    name: {{ include "wayfinder.name" . }}-apiserver
{{ include "wayfinder.labels.api" . | indent 4}}
spec:
  type: {{ .Values.api.serviceType }}
  ports:
  - name: http
    port: {{ .Values.api.port }}
    targetPort: 10080
  selector:
    name: {{ include "wayfinder.name" . }}-apiserver

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "wayfinder.name" . }}-apiserver
  labels:
{{ include "wayfinder.labels.api" . | indent 4}}
spec:
  replicas: {{ .Values.api.replicas }}
  selector:
    matchLabels:
      name: {{ include "wayfinder.name" . }}-apiserver
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    metadata:
      labels:
        name: {{ include "wayfinder.name" . }}-apiserver
        service: {{ include "wayfinder.name" . }}-apiserver
        {{- if .Values.api.azure.wayfinderMsiClientId }}
        # Must match the value of WayfinderMSISelector
        aadpodidbinding: {{ include "wayfinder.name" . }}-identity
        {{- end }}
{{ include "wayfinder.labels.api" . | indent 8}}
      annotations:
        prometheus.io/port: {{ .Values.api.metricsPort | quote }}
        prometheus.io/scheme: "http"
        prometheus.io/scrape: "true"
        {{- if .Values.api.aws.wayfinderIamIdentity }}
        # roll the deployment if this changes
        aws-role-arn: {{ .Values.api.aws.wayfinderIamIdentity }}
        {{- end }}
        # roll the deployment if any dependant values change
        checksum/api-secret: {{ include (print $.Template.BasePath "/secret.yaml.tpl") . | sha256sum }}
    spec:
      {{- if .Values.customTolerations }}
      tolerations: {{- .Values.customTolerations | toYaml | trim | nindent 8 }}
      {{- end }}
      affinity:
        {{- if .Values.customNodeAffinity }}
        nodeAffinity: {{- .Values.customNodeAffinity | toYaml | trim | nindent 10 }}
        {{- end }}
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                  - key: name
                    operator: In
                    values:
                    - {{ include "wayfinder.name" . }}-apiserver
                topologyKey: failure-domain.beta.kubernetes.io/zone
            - weight: 95
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                  - key: name
                    operator: In
                    values:
                    - {{ include "wayfinder.name" . }}-apiserver
                topologyKey: kubernetes.io/hostname

      serviceAccountName: {{ include "wayfinder.name" . }}-admin
      securityContext:
        fsGroup: 65534
        runAsNonRoot: true
        runAsUser: 65534

      volumes:
        - name: ca
          secret:
            secretName: {{ .Values.ca.secretName }}
        - name: webhooks-certs
          secret:
            secretName: {{ default .Values.webhooks.tls.secretName (printf "%s-%s" (include "wayfinder.name" . ) "webhooks-tls") }}
        {{- if .Values.api.tls.enabled }}
        - name: tls
          secret:
            secretName: {{ default .Values.api.tls.secretName (printf "%s-%s" (include "wayfinder.name" . ) "api-tls") }}
        {{- end}}

      containers:
        - name: apiserver
          image: {{ .Values.api.image }}
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
              - all
          resources:
            requests:
              cpu: "50m"
              memory: "100Mi"
          ports:
            - name: http
              containerPort: 10080
              {{- if .Values.api.hostPort }}
              hostPort: {{ .Values.api.hostPort }}
              {{- end }}
            {{- if .Values.api.enableMetrics }}
            - name: metrics
              containerPort: {{ .Values.api.metricsPort }}
            {{- end }}
            {{- if .Values.api.enableProfiling }}
            - name: pprof
              containerPort: {{ .Values.api.profilingPort }}
            {{- end }}

          # On first startup, the API server needs to wait for the Wayfinder CRDs and Wayfinder RBAC
          # to be set up by the init container of the controller, so set a suitably long timeout so
          # we don't continually kill the API server pod into crash-loop backoff before its even 
          # started.
          startupProbe:
            httpGet:
              path: /healthz
              port: 10080
              scheme: {{ if .Values.api.tls.enabled }}HTTPS{{ else }}HTTP{{ end}}
            failureThreshold: 150
            periodSeconds: 2
          livenessProbe:
            httpGet:
              path: /healthz
              port: 10080
              scheme: {{ if .Values.api.tls.enabled }}HTTPS{{ else }}HTTP{{ end}}
            initialDelaySeconds: 5
          readinessProbe:
            httpGet:
              path: /healthz
              port: 10080
              scheme: {{ if .Values.api.tls.enabled }}HTTPS{{ else }}HTTP{{ end}}
            initialDelaySeconds: 5

          env:
{{ include "apiserver.env" . | indent 12 }}
            - name: WF_RUN_API
              value: "true"
            - name: WF_VERBOSE
              value: "{{ .Values.api.verbose }}"
            - name: WF_TRACE
              value: "{{ .Values.api.trace }}"
            - name: WF_ENABLE_PROFILING
              value: "{{ .Values.api.enableProfiling }}"
            - name: WF_PROFILING_PORT
              value: "{{ .Values.api.profilingPort }}"
            - name: WF_ENABLE_METRICS
              value: "{{ .Values.api.enableMetrics }}"
            - name: WF_METRICS_PORT
              value: "{{ .Values.api.metricsPort }}"
            {{- if .Values.kognizer.enabled }}
            - name: WF_KOGNIZER_URL
              value: "{{ printf "https://%s/data/api/v1alpha1/" .Values.api.ingress.hostname }}"
            {{- end }}

          envFrom:
            - secretRef:
                name: {{ include "wayfinder.name" . }}-mysql
            - secretRef:
                name: {{ include "wayfinder.name" . }}-api
            - secretRef:
                name: {{ include "wayfinder.name" . }}-api-static
            {{- if (.Values.wink) }}
            - secretRef:
                name: {{ include "wayfinder.name" . }}-kube-access
            {{- end }}

          volumeMounts:
          - name: ca
            readOnly: true
            mountPath: /secrets/ca
          {{- if .Values.api.tls.enabled }}
          - name: tls
            readOnly: true
            mountPath: /secrets/tls
          {{- end }}
