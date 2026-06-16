{{- define "business-ai-app.namespace" -}}
{{- .Values.namespace.name -}}
{{- end -}}

{{- define "business-ai-app.name" -}}
spend-control
{{- end -}}

{{- define "business-ai-app.serviceAccountName" -}}
{{- .Values.serviceAccount.name -}}
{{- end -}}

{{- define "business-ai-app.configMapName" -}}
{{- if .Values.config.existingConfigMapName -}}
{{- .Values.config.existingConfigMapName -}}
{{- else -}}
spend-control-config
{{- end -}}
{{- end -}}

{{- define "business-ai-app.secretName" -}}
{{- if .Values.secrets.existingSecretName -}}
{{- .Values.secrets.existingSecretName -}}
{{- else -}}
spend-control-secrets
{{- end -}}
{{- end -}}
