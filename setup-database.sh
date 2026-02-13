#!/bin/bash

# Script para Configurar Base de Datos en Google Cloud SQL
# Este script automatiza la creación de la base de datos

set -e

echo "🗄️  Configurando Base de Datos en Google Cloud SQL..."

# Variables (modifica según tus necesidades)
PROJECT_ID="${GCP_PROJECT_ID:-proyecto-blockchain-linsi}"
INSTANCE_NAME="${DB_INSTANCE:-blockchain-db}"
DATABASE_NAME="${DB_NAME:-blockchain}"
DB_USER="${DB_USER:-appuser}"
REGION="${GCP_REGION:-us-central1}"

echo "📋 Configuración:"
echo "  - Proyecto: $PROJECT_ID"
echo "  - Instancia: $INSTANCE_NAME"
echo "  - Base de datos: $DATABASE_NAME"
echo "  - Usuario: $DB_USER"
echo "  - Región: $REGION"

# Solicitar contraseñas
echo ""
read -sp "🔐 Ingresa la contraseña ROOT para la instancia: " ROOT_PASSWORD
echo ""
read -sp "🔐 Ingresa la contraseña para el usuario $DB_USER: " USER_PASSWORD
echo ""

# Configurar proyecto
gcloud config set project "$PROJECT_ID"

# Habilitar API
echo "⚙️  Habilitando Cloud SQL API..."
gcloud services enable sqladmin.googleapis.com

# Crear instancia
echo "🔨 Creando instancia de Cloud SQL (esto puede tardar varios minutos)..."
gcloud sql instances create "$INSTANCE_NAME" \
  --database-version=POSTGRES_14 \
  --tier=db-f1-micro \
  --region="$REGION" \
  --root-password="$ROOT_PASSWORD" \
  || echo "⚠️  La instancia ya existe o hubo un error"

# Esperar a que la instancia esté lista
echo "⏳ Esperando a que la instancia esté lista..."
sleep 10

# Crear base de datos
echo "📊 Creando base de datos..."
gcloud sql databases create "$DATABASE_NAME" \
  --instance="$INSTANCE_NAME" \
  || echo "⚠️  La base de datos ya existe"

# Crear usuario
echo "👤 Creando usuario..."
gcloud sql users create "$DB_USER" \
  --instance="$INSTANCE_NAME" \
  --password="$USER_PASSWORD" \
  || echo "⚠️  El usuario ya existe"

# Obtener información de conexión
echo ""
echo "✅ Configuración completada!"
echo ""
echo "📝 Información de conexión:"
echo "════════════════════════════════════════════════"

CONNECTION_NAME=$(gcloud sql instances describe "$INSTANCE_NAME" --format="value(connectionName)")
IP_ADDRESS=$(gcloud sql instances describe "$INSTANCE_NAME" --format="value(ipAddresses[0].ipAddress)")

echo "Connection Name: $CONNECTION_NAME"
echo "IP Address: $IP_ADDRESS"
echo "Database: $DATABASE_NAME"
echo "User: $DB_USER"
echo ""
echo "🔗 Cadena de conexión para Cloud Run/App Engine:"
echo "postgresql://$DB_USER:PASSWORD@/$DATABASE_NAME?host=/cloudsql/$CONNECTION_NAME"
echo ""
echo "🔗 Cadena de conexión directa (requiere autorizar IP):"
echo "postgresql://$DB_USER:PASSWORD@$IP_ADDRESS:5432/$DATABASE_NAME"
echo ""
echo "💡 Para conectarte localmente, instala Cloud SQL Proxy:"
echo "  ./cloud_sql_proxy -instances=$CONNECTION_NAME=tcp:5432"
echo ""
echo "📚 Documentación: https://cloud.google.com/sql/docs/postgres/connect-run"
