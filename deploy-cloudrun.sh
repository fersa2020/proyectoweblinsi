#!/bin/bash

# Script de Despliegue Automático para Google Cloud Run
# Este script simplifica el proceso de despliegue

set -e  # Detener en caso de error

echo "🚀 Iniciando despliegue en Google Cloud Run..."

# Variables (modifica según tu proyecto)
PROJECT_ID="${GCP_PROJECT_ID:-proyecto-blockchain-linsi}"
APP_NAME="${APP_NAME:-blockchain-app}"
REGION="${GCP_REGION:-us-central1}"

echo "📋 Configuración:"
echo "  - Proyecto: $PROJECT_ID"
echo "  - Aplicación: $APP_NAME"
echo "  - Región: $REGION"

# Configurar el proyecto
echo "⚙️  Configurando proyecto..."
gcloud config set project "$PROJECT_ID"

# Construir la imagen
echo "🔨 Construyendo imagen Docker..."
gcloud builds submit --tag "gcr.io/$PROJECT_ID/$APP_NAME"

# Desplegar en Cloud Run
echo "📦 Desplegando en Cloud Run..."
gcloud run deploy "$APP_NAME" \
  --image "gcr.io/$PROJECT_ID/$APP_NAME" \
  --platform managed \
  --region "$REGION" \
  --allow-unauthenticated

# Obtener la URL de la aplicación
echo "✅ Despliegue completado!"
echo ""
echo "🌐 URL de la aplicación:"
gcloud run services describe "$APP_NAME" \
  --platform managed \
  --region "$REGION" \
  --format "value(status.url)"

echo ""
echo "📊 Para ver los logs:"
echo "  gcloud run logs read $APP_NAME --limit 50"
