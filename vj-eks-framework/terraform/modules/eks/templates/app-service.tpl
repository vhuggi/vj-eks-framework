apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.name }}-service
  labels:
    app: {{ .Values.name }}
spec:
  ports:
    - name: http
      port: 80
      targetPort: {{ .Values.container_port }}
  selector:
    app: {{ .Values.name }}
  type: NodePort

