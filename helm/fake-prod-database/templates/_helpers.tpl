{{- define "fake-prod-database.name" -}}
fake-prod-database
{{- end -}}

{{- define "fake-prod-database.postgresName" -}}
{{- .Values.postgres.name -}}
{{- end -}}

{{- define "fake-prod-database.generatorName" -}}
{{- .Values.generator.name -}}
{{- end -}}

{{- define "fake-prod-database.labels" -}}
app.kubernetes.io/part-of: fake-prod-database
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}
