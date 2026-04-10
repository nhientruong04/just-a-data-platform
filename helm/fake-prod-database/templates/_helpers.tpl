{{- define "prod-postgres-database.name" -}}
prod-postgres-db
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
