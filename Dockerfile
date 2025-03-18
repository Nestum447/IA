FROM ubuntu:22.04

# Instalar dependencias y librerías necesarias
RUN apt update && apt install -y python3 python3-pip

# Instalar GPT4All y Streamlit
RUN pip install streamlit gpt4all

# Configurar el directorio de trabajo
WORKDIR /app

# Copiar los archivos de la app al contenedor
COPY . /app

# Ejecutar la app de Streamlit al iniciar el contenedor
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
