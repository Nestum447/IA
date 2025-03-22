# Usa Ubuntu 24.04 con GLIBC 2.35
FROM ubuntu:24.04

# Actualizar paquetes e instalar dependencias adicionales
RUN apt update && apt install -y \
    python3 python3-pip \
    wget curl git \
    build-essential cmake unzip \
    gcc g++ libstdc++6

# Instalar Streamlit y GPT4All
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
