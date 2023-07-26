# Utilizamos la imagen base de Python con Alpine Linux para una imagen más liviana
FROM python:3.9-alpine

# Aseguramos que el puerto 5000 esté expuesto para acceder a la aplicación Flask
EXPOSE 5000

# Copiamos el código de la aplicación al contenedor
COPY app.py /app.py

# Instalamos Flask en el contenedor
RUN pip install --no-cache-dir flask

# Comando para ejecutar la aplicación Flask en el contenedor
CMD ["python", "/app.py"]
