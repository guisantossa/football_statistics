import streamlit as st
from utils.data_loader import load_players

st.title("⚽ Scouting de Jogadores")
df = load_players()

# Filtro por posição
position = st.radio("Posição", ["Atacante", "Meio-campo", "Zagueiro"])
st.dataframe(df[df["position"] == position])