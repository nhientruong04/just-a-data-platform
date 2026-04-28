{{- define "apicurio.name" -}}
{{- .Values.registry.name -}}
{{- end -}}

{{- define "apicurio.fullname" -}}
{{- printf "dp-%s" (include "apicurio.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "apicurio.postgres.name" -}}
{{- .Values.postgres.name -}}
{{- end -}}

{{- define "apicurio.postgres.fullname" -}}
{{- printf "dp-%s" (include "apicurio.postgres.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "apicurio.serviceName" -}}
{{- printf "%s-endpoint" (include "apicurio.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "apicurio.postgres.serviceName" -}}
{{- printf "%s-endpoint" (include "apicurio.postgres.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "apicurio.labels" -}}
app.kubernetes.io/name: {{ include "apicurio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: schema-registry
app.kubernetes.io/part-of: data-platform
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "apicurio.postgres.labels" -}}
app.kubernetes.io/name: {{ include "apicurio.postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: schema-registry-storage
app.kubernetes.io/part-of: data-platform
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "apicurio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apicurio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "apicurio.postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apicurio.postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
