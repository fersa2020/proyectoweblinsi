"""
Aplicación de Ejemplo para Despliegue en Google Cloud
Este es un ejemplo simple que puedes usar como base
"""

from flask import Flask, jsonify, request
import os
from datetime import datetime

app = Flask(__name__)

# Puerto configurado por Cloud Run (variable de entorno PORT)
PORT = int(os.environ.get('PORT', 8080))

# Variable de entorno para la base de datos (ejemplo)
DATABASE_URL = os.environ.get('DATABASE_URL', 'no-configurada')


@app.route('/')
def home():
    """Página principal"""
    return jsonify({
        'proyecto': 'Certificado de Alumno Regular con Blockchain',
        'status': 'activo',
        'timestamp': datetime.now().isoformat(),
        'mensaje': '¡Aplicación desplegada exitosamente en Google Cloud!'
    })


@app.route('/health')
def health():
    """Endpoint de salud para Cloud Run"""
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.now().isoformat()
    })


@app.route('/info')
def info():
    """Información de configuración"""
    return jsonify({
        'port': PORT,
        'database_configured': DATABASE_URL != 'no-configurada',
        'environment': os.environ.get('PYTHON_ENV', 'development')
    })


@app.route('/api/certificados', methods=['GET', 'POST'])
def certificados():
    """Ejemplo de endpoint API para certificados"""
    if request.method == 'POST':
        data = request.get_json()
        return jsonify({
            'mensaje': 'Certificado registrado (ejemplo)',
            'datos': data,
            'blockchain_hash': 'example_hash_' + datetime.now().strftime('%Y%m%d%H%M%S')
        }), 201
    else:
        # GET - listar certificados (ejemplo)
        return jsonify({
            'certificados': [
                {
                    'id': 1,
                    'alumno': 'Juan Pérez',
                    'curso': 'LINSI 2024',
                    'hash': 'abc123...'
                },
                {
                    'id': 2,
                    'alumno': 'María García',
                    'curso': 'LINSI 2024',
                    'hash': 'def456...'
                }
            ]
        })


if __name__ == '__main__':
    print(f'🚀 Iniciando servidor en puerto {PORT}')
    print(f'🗄️  Database URL: {DATABASE_URL[:20]}...')
    app.run(host='0.0.0.0', port=PORT, debug=False)
