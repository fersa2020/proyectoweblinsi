# Dockerfile para desplegar en Google Cloud Run
# Este archivo facilita el despliegue de tu aplicación

# Usa una imagen base oficial de Python
FROM python:3.11-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY requirements.txt ./

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la aplicación
COPY . .

# Expone el puerto (Cloud Run usa la variable PORT)
ENV PORT=8080
EXPOSE 8080

# Comando para iniciar la aplicación con gunicorn
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
