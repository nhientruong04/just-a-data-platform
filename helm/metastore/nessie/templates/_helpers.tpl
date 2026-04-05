{{- define "nessie.name" -}}
nessie
{{- end -}}

{{- define "nessie.fullname" -}}
dp-nessie
{{- end -}}

{{- define "nessie.labels" -}}
app.kubernetes.io/name: {{ include "nessie.name" . }}
app.kubernetes.io/component: metastore
app.kubernetes.io/instance: dp
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "nessie.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nessie.name" . }}
app.kubernetes.io/component: metastore
app.kubernetes.io/instance: dp
{{- end -}}
