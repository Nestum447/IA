# Usa Ubuntu 22.04 (compatible con GLIBC 2.35)
FROM ubuntu:22.04

# Instalar herramientas necesarias
RUN apt update && apt install -y \
    build-essential \
    manpages-dev \
    python3 python3-pip wget curl \
    git cmake unzip

# Descargar y compilar GLIBC 2.35 correctamente
WORKDIR /tmp
RUN wget http://ftp.gnu.org/gnu/libc/glibc-2.35.tar.gz && \
    tar -xvzf glibc-2.35.tar.gz && \
    cd glibc-2.35 && \
    mkdir build && cd build && \
    ../configure --prefix=/opt/glibc-2.35 && \
    make -j$(nproc) && \
    make install && \
    cd / && rm -rf /tmp/glibc-2.35 /tmp/glibc-2.35.tar.gz

# Configurar el entorno para usar GLIBC 2.35
ENV LD_LIBRARY_PATH=/opt/glibc-2.35/lib:$LD_LIBRARY_PATH

# Instalar GPT4All y Streamlit
RUN pip install --upgrade pip && pip install streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
