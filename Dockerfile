# Usa Ubuntu 22.04 para garantizar compatibilidad con GLIBC 2.35
FROM ubuntu:22.04

# Instalar dependencias y actualizar paquetes
RUN apt update && apt install -y python3 python3-pip wget curl build-essential manpages-dev

# Descargar y compilar GLIBC 2.35
RUN wget http://ftp.gnu.org/gnu/libc/glibc-2.35.tar.gz && \
    tar -xvzf glibc-2.35.tar.gz && \
    cd glibc-2.35 && \
    mkdir build && cd build && \
    ../configure --prefix=/opt/glibc-2.35 && \
    make -j$(nproc) && \
    make install && \
    cd / && rm -rf glibc-2.35 glibc-2.35.tar.gz

# Configurar el entorno para usar GLIBC 2.35
ENV LD_LIBRARY_PATH=/opt/glibc-2.35/lib:$LD_LIBRARY_PATH

# Instalar GPT4All y Streamlit
RUN pip install streamlit gpt4all

# Definir directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación
CMD ["streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
