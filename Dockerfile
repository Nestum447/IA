# Usa Debian Testing con GLIBC 2.35 preinstalado
FROM debian:testing

# Instalar herramientas necesarias
RUN apt update && apt install -y \
    python3 python3-pip \
    python3-venv \
    wget curl git \
    build-essential cmake unzip \
    gcc g++ libstdc++6

# Crear entorno virtual
WORKDIR /app
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Instalar dependencias dentro del entorno virtual
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir streamlit gpt4all

# Copiar archivos de la aplicación
COPY . /app

# Exponer el puerto de Streamlit
EXPOSE 8501

# Ejecutar la aplicación dentro del entorno virtual
CMD ["/app/venv/bin/python", "-m", "streamlit", "run", "IAST.py", "--server.port=8501", "--server.address=0.0.0.0"]
