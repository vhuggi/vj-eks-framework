apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.name }}-deployment
spec:
  replicas: {{ .Values.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.name }}
    spec:
      containers:
        - name: {{ .Values.name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          env:
            - name: REDIS_HOST
              value: {{ .Values.redis_host }}
            - name: REDIS_PORT
              value: {{ .Values.redis_port }}
            - name: REDIS_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: redis
                  key: password
          ports:
            - name: http
              containerPort: {{ .Values.container_port }}
          imagePullPolicy: Always

