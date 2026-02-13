# Guía de Inicio Rápido

## Despliegue en 5 Minutos

### Prerrequisitos

1. Cuenta de Google Cloud ([Crear cuenta gratis con $300 USD](https://cloud.google.com/free))
2. Google Cloud SDK instalado ([Instrucciones](https://cloud.google.com/sdk/docs/install))

### Paso 1: Configuración Inicial

```bash
# Iniciar sesión
gcloud auth login

# Crear proyecto
gcloud projects create mi-proyecto-blockchain --name="Mi Proyecto Blockchain"

# Configurar proyecto
gcloud config set project mi-proyecto-blockchain
```

### Paso 2: Habilitar APIs

```bash
gcloud services enable cloudbuild.googleapis.com run.googleapis.com
```

### Paso 3: Desplegar

```bash
# Clonar el repositorio (si aún no lo has hecho)
git clone https://github.com/fersa2020/proyectoweblinsi.git
cd proyectoweblinsi

# Hacer ejecutables los scripts
chmod +x deploy-cloudrun.sh setup-database.sh

# Desplegar la aplicación
./deploy-cloudrun.sh
```

¡Eso es todo! Tu aplicación estará disponible en una URL de Cloud Run.

### Paso 4: Agregar Base de Datos (Opcional)

```bash
./setup-database.sh
```

## Comandos Útiles

### Ver logs

```bash
gcloud run logs read blockchain-app --limit 50
```

### Ver URL de la aplicación

```bash
gcloud run services list
```

### Actualizar la aplicación

Simplemente ejecuta el script de despliegue nuevamente:

```bash
./deploy-cloudrun.sh
```

## Solución de Problemas

### Error: "Project not found"

```bash
# Verifica que el proyecto existe
gcloud projects list

# Configura el proyecto correcto
gcloud config set project TU_PROJECT_ID
```

### Error: "Permission denied"

```bash
# Verifica que tienes permisos
gcloud auth list
```

### Necesitas ayuda?

Consulta la [Guía Completa de Despliegue](DEPLOY_GOOGLE_CLOUD.md) para más detalles.

## Costos

- **Aplicación pequeña**: $0-5 USD/mes con la capa gratuita de Cloud Run
- **Con base de datos**: $10-20 USD/mes con Cloud SQL
- **Créditos gratuitos**: $300 USD para nuevos usuarios por 90 días

## Siguientes Pasos

1. Personaliza la aplicación en `app.py`
2. Agrega tu lógica de blockchain
3. Conecta a una base de datos
4. Configura un dominio personalizado
5. Agrega autenticación

Para más información, consulta la [documentación completa](DEPLOY_GOOGLE_CLOUD.md).
