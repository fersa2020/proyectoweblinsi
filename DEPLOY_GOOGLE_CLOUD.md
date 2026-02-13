# Guía de Despliegue en Google Cloud

## Respuesta a la pregunta: ¿Es difícil usar Google Cloud?

**No, no es difícil.** Con esta guía paso a paso, podrás desplegar tu aplicación y base de datos en Google Cloud de manera sencilla.

## Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Configuración Inicial](#configuración-inicial)
3. [Opción 1: Despliegue con Cloud Run (Recomendado)](#opción-1-cloud-run)
4. [Opción 2: Despliegue con App Engine](#opción-2-app-engine)
5. [Configuración de Base de Datos](#configuración-de-base-de-datos)
6. [Scripts de Despliegue Automático](#scripts-de-despliegue)

---

## Requisitos Previos

### 1. Crear una Cuenta de Google Cloud

- Visita: https://cloud.google.com/
- Obtén $300 USD de crédito gratis para nuevos usuarios
- Período de prueba: 90 días

### 2. Instalar Google Cloud SDK

```bash
# En Linux/Mac:
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# En Windows:
# Descarga el instalador desde:
# https://cloud.google.com/sdk/docs/install
```

### 3. Verificar Instalación

```bash
gcloud --version
```

---

## Configuración Inicial

### 1. Inicializar gcloud

```bash
# Iniciar sesión
gcloud auth login

# Crear un nuevo proyecto (o usar uno existente)
gcloud projects create proyecto-blockchain-linsi --name="Proyecto Blockchain LINSI"

# Configurar el proyecto como predeterminado
gcloud config set project proyecto-blockchain-linsi

# Habilitar APIs necesarias
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable sqladmin.googleapis.com
```

### 2. Configurar la Región

```bash
# Configurar región (ejemplo: us-central1)
gcloud config set run/region us-central1
```

---

## Opción 1: Cloud Run (Recomendado)

**Ventajas:**
- ✅ Escalado automático (de 0 a infinito)
- ✅ Solo pagas por lo que usas
- ✅ Fácil de configurar
- ✅ Compatible con Docker

### Paso 1: Crear Dockerfile

Ya incluido en este repositorio como `Dockerfile`.

### Paso 2: Construir y Desplegar

```bash
# Construir la imagen
gcloud builds submit --tag gcr.io/proyecto-blockchain-linsi/app

# Desplegar en Cloud Run
gcloud run deploy blockchain-app \
  --image gcr.io/proyecto-blockchain-linsi/app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars "DATABASE_URL=postgresql://user:pass@host/db"
```

### Paso 3: Obtener la URL

```bash
gcloud run services describe blockchain-app \
  --platform managed \
  --region us-central1 \
  --format "value(status.url)"
```

---

## Opción 2: App Engine

**Ventajas:**
- ✅ Muy simple para aplicaciones web tradicionales
- ✅ Configuración con un solo archivo
- ✅ Infraestructura totalmente administrada

### Paso 1: Crear app.yaml

Ya incluido en este repositorio como `app.yaml`.

### Paso 2: Desplegar

```bash
# Desplegar la aplicación
gcloud app deploy

# Ver la aplicación en el navegador
gcloud app browse
```

---

## Configuración de Base de Datos

### Opción A: Cloud SQL (PostgreSQL)

#### 1. Crear Instancia

```bash
# Crear instancia de PostgreSQL
gcloud sql instances create blockchain-db \
  --database-version=POSTGRES_14 \
  --tier=db-f1-micro \
  --region=us-central1 \
  --root-password=TU_PASSWORD_SEGURO
```

#### 2. Crear Base de Datos

```bash
# Crear la base de datos
gcloud sql databases create blockchain \
  --instance=blockchain-db
```

#### 3. Crear Usuario

```bash
# Crear usuario
gcloud sql users create appuser \
  --instance=blockchain-db \
  --password=PASSWORD_DEL_USUARIO
```

#### 4. Obtener la Cadena de Conexión

```bash
# Ver detalles de conexión
gcloud sql instances describe blockchain-db
```

**Cadena de conexión:**
```
postgresql://appuser:PASSWORD@/blockchain?host=/cloudsql/INSTANCE_CONNECTION_NAME
```

### Opción B: Firestore (Base de Datos NoSQL)

Ideal para aplicaciones que no requieren SQL:

```bash
# Habilitar Firestore
gcloud firestore databases create --region=us-central1
```

---

## Scripts de Despliegue

### Usar el Script Automático

Este repositorio incluye scripts para facilitar el despliegue:

```bash
# Hacer el script ejecutable
chmod +x deploy-cloudrun.sh

# Ejecutar despliegue
./deploy-cloudrun.sh
```

---

## Costos Estimados

### Capa Gratuita (Free Tier)

Google Cloud ofrece recursos gratuitos permanentes:

- **Cloud Run**: 2 millones de peticiones/mes gratis
- **Cloud SQL**: No hay capa gratuita, pero db-f1-micro cuesta ~$10/mes
- **Firestore**: 1GB de almacenamiento gratis
- **Cloud Storage**: 5GB gratis

### Para una Aplicación Sencilla

- **Aplicación pequeña**: $0-5 USD/mes (con Cloud Run + Firestore)
- **Aplicación con SQL**: $10-20 USD/mes (con Cloud SQL)

---

## Monitoreo y Logs

### Ver Logs en Cloud Run

```bash
# Ver logs de la aplicación
gcloud run logs read blockchain-app --limit 50
```

### Ver Logs en App Engine

```bash
# Ver logs
gcloud app logs tail
```

---

## Solución de Problemas Comunes

### Error: "Permission denied"

```bash
# Asegúrate de tener los permisos correctos
gcloud projects add-iam-policy-binding proyecto-blockchain-linsi \
  --member=user:TU_EMAIL@gmail.com \
  --role=roles/owner
```

### Error: "API not enabled"

```bash
# Habilitar todas las APIs necesarias
gcloud services enable cloudbuild.googleapis.com run.googleapis.com
```

### Error de Conexión a Base de Datos

- Verifica que la instancia de Cloud SQL esté en la misma región
- Asegúrate de usar el Cloud SQL Proxy para conexiones locales
- Verifica las credenciales de la base de datos

---

## Recursos Adicionales

- [Documentación de Cloud Run](https://cloud.google.com/run/docs)
- [Documentación de App Engine](https://cloud.google.com/appengine/docs)
- [Documentación de Cloud SQL](https://cloud.google.com/sql/docs)
- [Calculadora de Precios](https://cloud.google.com/products/calculator)

---

## Conclusión

Desplegar en Google Cloud **NO es difícil**. Con esta guía:

1. ✅ Tienes opciones simples (App Engine) y potentes (Cloud Run)
2. ✅ Los costos son predecibles y bajos para aplicaciones pequeñas
3. ✅ La capa gratuita te permite empezar sin gastar
4. ✅ Los scripts automatizan el proceso

**¡Comienza hoy con los $300 USD de crédito gratuito!**
