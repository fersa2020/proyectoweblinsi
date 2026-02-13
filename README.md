# proyectoweblinsi

Proyecto de certificado de alumno regular con blockchain.

## 🚀 Despliegue en Google Cloud

**¿Es difícil desplegar en Google Cloud?** ¡No! Este proyecto incluye todo lo necesario para desplegar fácilmente.

### 📖 Documentación Completa

Lee la [Guía de Despliegue en Google Cloud](DEPLOY_GOOGLE_CLOUD.md) para instrucciones detalladas.

### ⚡ Despliegue Rápido

```bash
# Opción 1: Cloud Run (Recomendado)
chmod +x deploy-cloudrun.sh
./deploy-cloudrun.sh

# Opción 2: App Engine
chmod +x deploy-appengine.sh
./deploy-appengine.sh

# Configurar Base de Datos
chmod +x setup-database.sh
./setup-database.sh
```

### 🎯 Lo que incluye este proyecto

- ✅ Aplicación de ejemplo lista para desplegar
- ✅ Configuración de Docker para Cloud Run
- ✅ Configuración de App Engine
- ✅ Scripts de despliegue automático
- ✅ Guía completa en español
- ✅ Ejemplos de endpoints API

### 💡 Características

- API REST para gestión de certificados
- Integración con blockchain (ejemplo)
- Listo para Cloud SQL o Firestore
- Escalado automático
- Monitoreo y logs integrados

### 📚 Recursos

- [Guía de Despliegue](DEPLOY_GOOGLE_CLOUD.md)
- [Google Cloud Console](https://console.cloud.google.com)
- [$300 USD Crédito Gratis](https://cloud.google.com/free)

## 🛠️ Desarrollo Local

```bash
# Instalar dependencias
pip install -r requirements.txt

# Ejecutar aplicación
python app.py
```

Visita http://localhost:8080

## 📝 Licencia

Este proyecto es de código abierto.
