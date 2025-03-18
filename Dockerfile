# Usa Ubuntu 22.04 para tener GLIBC 2.32+
FROM ubuntu:22.04

# Instalar dependencias necesarias
RUN apt update && apt install -y python3 python3-pip wget

# Instalar GPT4All y Streamlit
RUN pip install streamlit gpt4all

# Crear directorio de trabajo y copiar archivos
WORKDIR /app
COPY . /app

# Exponer el puerto 8501 para Streamlit
EXPOSE 8501

# Ejecutar la app de Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
