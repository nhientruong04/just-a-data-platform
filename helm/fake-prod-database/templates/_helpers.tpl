{{- define "prod-postgres-database.serviceName" -}}
{{- .Values.postgres.name -}}-endpoint
{{- end -}}

{{- define "prod-postgres-database.postgresName" -}}
{{- .Values.postgres.name -}}
{{- end -}}

{{- define "prod-postgres-database.generatorName" -}}
{{- .Values.generator.name -}}
{{- end -}}

{{- define "prod-postgres-database.labels" -}}
app.kubernetes.io/part-of: prod-postgres-database
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}
