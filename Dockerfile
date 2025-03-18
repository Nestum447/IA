# Usa Ubuntu 22.04, que tiene GLIBC 2.35
FROM ubuntu:22.04

# Instalar herramientas necesarias
RUN apt update && apt install -y \
    python3 python3-pip \
    wget curl git \
    build-essential cmake unzip 

# Instalar GPT4All y Streamlit
RUN pip install --upgrade pip && pip install streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
