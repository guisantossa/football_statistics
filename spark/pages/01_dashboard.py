import streamlit as st
import plotly.express as px
from utils.session import init_global_state

init_global_state()  # Garante que os dados estão carregados

# ---- Dados Globais ---- #
df = st.session_state.matches_df
filters = st.session_state.filters

# ---- UI ---- #
st.title("📊 Dashboard de Partidas")
selected_league = st.selectbox("Liga", df["league"].unique(), key="league_filter")

# Atualiza filtros na sessão
if selected_league != filters["league"]:
    st.session_state.filters["league"] = selected_league
    st.rerun()  # Recarrega a página para aplicar filtros

# ---- Gráfico ---- #
filtered_df = df[df["league"] == selected_league]
fig = px.scatter(filtered_df, x="posse_bola", y="gols", color="time_casa")
st.plotly_chart(fig, use_container_width=True)