import streamlit as st
import pandas as pd
import plotly.express as px

# Configuração inicial da página
st.set_page_config(
    page_title="Football Statistics",
    page_icon="⚽",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Dados de exemplo (substitua pelos seus dados reais)
@st.cache_data
def load_sample_data():
    return pd.DataFrame({
        'Jogador': ['Neymar', 'Mbappé', 'Messi', 'Haaland'],
        'Gols': [12, 15, 10, 18],
        'Assistências': [8, 6, 12, 4],
        'Time': ['PSG', 'PSG', 'Inter Miami', 'Man City']
    })

# ============ BARRA LATERAL ============
with st.sidebar:
    st.title("⚽ Controles")
    
    # Filtros
    liga = st.selectbox("Selecione a Liga:", ["Premier League", "La Liga", "Bundesliga", "Série A"])
    temporada = st.select_slider("Temporada:", options=["2022", "2023", "2024"])
    
    st.divider()
    
    # Filtros avançados
    with st.expander("Filtros Avançados"):
        intervalo_datas = st.date_input("Período:", [])
        estatistica = st.multiselect(
            "Estatísticas:",
            ["Gols", "Assistências", "Finalizações", "Passes"]
        )
    
    st.divider()
    st.info("Sistema desenvolvido para análise de estatísticas de futebol")

# ============ CONTEÚDO PRINCIPAL ============
st.title(f"📊 Estatísticas de Futebol - {liga} {temporada}")
st.caption("Análise avançada de desempenho de times e jogadores")

# Tabs principais
tab1, tab2, tab3 = st.tabs(["📈 Visão Geral", "👥 Jogadores", "⚔ Partidas"])

with tab1:
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Top 5 Jogadores")
        df = load_sample_data().sort_values('Gols', ascending=False)
        st.dataframe(df.head(), hide_index=True, use_container_width=True)
    
    with col2:
        st.subheader("Distribuição de Gols")
        fig = px.pie(df, names='Time', values='Gols')
        st.plotly_chart(fig, use_container_width=True)

with tab2:
    st.subheader("Estatísticas Individuais")
    jogador = st.selectbox("Selecione o Jogador:", df['Jogador'].unique())
    
    dados_jogador = df[df['Jogador'] == jogador].iloc[0]
    
    col1, col2, col3 = st.columns(3)
    col1.metric("Gols", dados_jogador['Gols'])
    col2.metric("Assistências", dados_jogador['Assistências'])
    col3.metric("Time", dados_jogador['Time'])

with tab3:
    st.subheader("Próximas Partidas")
    
    # Exemplo de cards de partidas
    col1, col2 = st.columns(2)
    
    with col1:
        with st.container(border=True):
            st.markdown("**PSG vs Bayern**")
            st.caption("Champions League - 15/05/2024")
            st.progress(65, text="Probabilidade de vitória: 65%")
    
    with col2:
        with st.container(border=True):
            st.markdown("**Barcelona vs Real Madrid**")
            st.caption("La Liga - 18/05/2024")
            st.progress(45, text="Probabilidade de vitória: 45%")

# Rodapé
st.divider()
st.markdown("""
<style>
footer {visibility: hidden;}
</style>
""", unsafe_allow_html=True)