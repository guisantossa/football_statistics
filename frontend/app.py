import streamlit as st
from streamlit_option_menu import option_menu
from modules import estatisticas, analise, bancas  # Importe as classes aqui

# 1. Configuração inicial
st.set_page_config(
    layout="wide",
    page_title="Sistema de Análise Esportiva"
)



# 3. Menu superior estilizado (mesmo código anterior)
selected = option_menu(
    menu_title=None,
    options=["Estatísticas e Predição", "Análise de Resultados", "Bancas de Apostas"],
    icons=["bar-chart-line", "clipboard-data", "coin"],
    default_index=0,
    orientation="horizontal",
    styles={
        # [Seus estilos permanecem iguais]
    }
)

# 4. Navegação por módulos - VERSÃO CORRIGIDA
if selected == "Estatísticas e Predição":
    stats = estatisticas()  # Cria uma instância da classe
    stats.app()  # Chama o método na instância

elif selected == "Análise de Resultados":
    analysis = analise()  # Cria uma instância da classe
    analysis.app()  # Chama o método na instância

elif selected == "Bancas de Apostas":
    bookmakers = bancas()  # Cria uma instância da classe
    bookmakers.app()  # Chama o método na instância