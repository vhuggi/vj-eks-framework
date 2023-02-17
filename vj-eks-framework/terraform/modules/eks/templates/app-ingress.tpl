apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: {{ .Values.name }}-ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/subnets: {{ join "," .Values.subnets }}
    alb.ingress.kubernetes.io/security-groups: {{ .Values.security_groups }}
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80},{"HTTPS":443}]'
    alb.ingress.kubernetes.io/healthcheck-path: {{ .Values.healthcheck_path }}
    alb.ingress.kubernetes.io/healthcheck-port: http
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: "30"
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: "5"
    alb.ingress.kubernetes.io/success-codes: "200-399"
spec:
  rules:
    - http:
        paths:
          - path: /*
            backend:
              serviceName: {{ .Values.name }}-service
              servicePort: http

