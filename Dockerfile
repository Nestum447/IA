# Usa Debian Testing, que tiene GLIBC 2.35
FROM debian:testing

# Instalar herramientas necesarias
RUN apt update && apt install -y \
    python3 python3-pip \
    wget curl git \
    build-essential cmake unzip 

# Corregir instalación de paquetes Python
RUN python3 -m pip install --upgrade pip && pip install --no-cache-dir streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
