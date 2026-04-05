{{- define "minio.name" -}}
minio
{{- end -}}

{{- define "minio.fullname" -}}
dp-minio
{{- end -}}

{{- define "minio.labels" -}}
app.kubernetes.io/name: {{ include "minio.name" . }}
app.kubernetes.io/component: storage
app.kubernetes.io/instance: dp
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "minio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "minio.name" . }}
app.kubernetes.io/component: storage
app.kubernetes.io/instance: dp
{{- end -}}
