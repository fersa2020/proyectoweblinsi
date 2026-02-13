#!/bin/bash

# Script de Despliegue para Google App Engine
# Uso: ./deploy-appengine.sh

set -e  # Detener en caso de error

echo "🚀 Iniciando despliegue en Google App Engine..."

# Variables
PROJECT_ID="${GCP_PROJECT_ID:-proyecto-blockchain-linsi}"

echo "📋 Proyecto: $PROJECT_ID"

# Configurar el proyecto
echo "⚙️  Configurando proyecto..."
gcloud config set project "$PROJECT_ID"

# Desplegar
echo "📦 Desplegando aplicación..."
gcloud app deploy --quiet

# Obtener la URL
echo "✅ Despliegue completado!"
echo ""
echo "🌐 Abriendo aplicación en el navegador..."
gcloud app browse

echo ""
echo "📊 Para ver los logs:"
echo "  gcloud app logs tail"
