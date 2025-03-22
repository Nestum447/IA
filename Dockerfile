# Usa Ubuntu 22.04
FROM ubuntu:22.04

# Instalar herramientas necesarias
RUN apt update && apt install -y \
    build-essential manpages-dev wget curl git \
    python3 python3-pip cmake unzip gcc g++ libstdc++6

# Descargar y compilar GLIBC 2.35
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
