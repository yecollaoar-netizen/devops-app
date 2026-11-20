#!/bin/bash
set -e

echo "Actualizando codigo..."
git pull || echo "Sin repositorio remoto, se omite git pull"

echo "Reconstruyendo y levantando contenedores..."
docker compose up -d --build

echo "Esperando a que arranque..."
sleep 3

echo "Verificando /health..."
if curl -fs http://localhost/health | grep -q "OK"; then
    echo "Despliegue exitoso"
else
    echo "ERROR: /health no responde"
    exit 1
fi
