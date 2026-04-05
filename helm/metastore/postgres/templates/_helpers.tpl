{{- define "nessie-postgres.name" -}}
nessie-postgres
{{- end -}}

{{- define "nessie-postgres.fullname" -}}
dp-nessie-postgres
{{- end -}}

{{- define "nessie-postgres.labels" -}}
app.kubernetes.io/name: {{ include "nessie-postgres.name" . }}
app.kubernetes.io/component: metastore
app.kubernetes.io/instance: dp
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "nessie-postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nessie-postgres.name" . }}
app.kubernetes.io/component: metastore
app.kubernetes.io/instance: dp
{{- end -}}
