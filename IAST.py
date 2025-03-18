import streamlit as st
from gpt4all import GPT4All

# Cargar el modelo (ajusta la ruta si es necesario)
modelo = GPT4All("models/gpt4all-falcon-q4_0.gguf")
modelo.open()

st.title("🤖 Asistente IA para Estudiantes")

pregunta = st.text_input("Escribe tu pregunta:")

if st.button("Responder"):
    if pregunta:
        respuesta = modelo.generate(pregunta)
        st.write("**Respuesta:**", respuesta)
    else:
        st.warning("Por favor, ingresa una pregunta.")
