# Usa una imagen de Ubuntu con GLIBC 2.35 ya instalada
FROM frolvlad/alpine-glibc:alpine-3.15_glibc-2.35

# Instalar herramientas necesarias
RUN apk add --no-cache \
    python3 \
    py3-pip \
    bash \
    curl \
    git

# Instalar GPT4All y Streamlit
RUN pip3 install --upgrade pip && pip3 install streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
