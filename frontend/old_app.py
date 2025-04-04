import streamlit as st
import pandas as pd
import os
import sys
# Adiciona o diretório raiz ao PYTHONPATH
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../')))
#import sparkCode.sport_statistics_processor as AnaliseDesempenho


st.set_page_config(layout="wide")
countries = [("Inglaterra", 1), ("Brasil", 2)]

def main():
    st.title('Análise de Desempenho de Ligas ⚽')
    
     # Seleção do país no sidebar
    selected_country = st.sidebar.selectbox("Selecione o país", options=[c[0] for c in countries])
    country_id = dict(countries)[selected_country]
    
    # Guardar na session state
    st.session_state["country_id"] = country_id
    st.session_state["country_name"] = selected_country

    analise = AnaliseDesempenho.SportsStatisticsProcessor(country_id)

    # Exibir o país selecionado
    st.sidebar.write(f"País selecionado: {selected_country}")

    # Menu só aparece após seleção do país
    menu = ['Análise de Desempenho dos Times', 
            'Análise Estatística',
            'Análise de Resultados por Rodada', 
            'Distribuição de Gols', 
            'Comparação entre Times', 
            'Tendências',
            'Jogos']

    choice = st.sidebar.selectbox('Selecione uma análise', menu)
    st.title(f'Análise de Desempenho - {selected_country}')
    st.write(f"Análise escolhida: **{choice}**")

    # Menu só aparece após seleção do país
    func_map = {'Análise de Desempenho dos Times': analise_desempenho_times, 
            'Análise Estatística': analise_estatistica,
            'Análise de Resultados por Rodada': analise_resultados_rodada, 
            'Distribuição de Gols': distribuicao_gols, 
            'Comparação entre Times': comparacao_times, 
            'Tendências': analise_tendencias,
            'Jogos': jogos
    }
    func_map.get(choice, lambda: st.write("Opção inválida"))(analise)

#funcao que mostra todos os jogos
def jogos(analise):
    st.title("Jogos da Premier League por Rodada")

    #processar jogos
    process_data =  analise.load_matches()

    # Pegando o range das rodadas
    rodadas = sorted(process_data["rodada"].unique())

    # Pegando o estado da rodada atual
    if "rodada_atual" not in st.session_state:
        st.session_state.rodada_atual = rodadas[0]

    col1, col2, col3 = st.columns(3)

    # Botão Rodada Anterior
    with col1:
        if st.button("⏪ Rodada Anterior"):
            change_rodada(rodadas, -1)

    with col2:
        rodada_selecionada = st.selectbox("Escolha a rodada:", rodadas, index=rodadas.index(st.session_state.rodada_atual))
        st.session_state.rodada_atual = rodada_selecionada

    with col3:
        if st.button("Próxima Rodada ⏩"):
            change_rodada(rodadas, 1)

    st.markdown(f"### Jogos da Rodada {st.session_state.rodada_atual}")
    
    # Filtrando o dataframe pela rodada escolhida
    df_rodada = process_data[process_data["rodada"] == st.session_state.rodada_atual]
    st.dataframe(df_rodada, width=800, height=400)

# Função auxiliar para mudança de rodada
def change_rodada(rodadas, direction):
    rodada_idx = rodadas.index(st.session_state.rodada_atual)
    new_rodada_idx = rodada_idx + direction
    if 0 <= new_rodada_idx < len(rodadas):
        st.session_state.rodada_atual = rodadas[new_rodada_idx]

def analise_estatistica(analise):
    st.subheader('Análise Estatística')

    # Carrega a lista de times
    times = analise.carrega_times()
    times_list = [(time['id'], time['time']) for time in times.to_dict(orient='records')]

    # Selectbox para selecionar o time
    time_selecionado_id, time_selecionado_nome = st.selectbox(
        'Selecione o time', times_list, format_func=lambda x: x[1]
    )

    # Consulta as estatísticas do time selecionado
    estatisticas, partidas = analise_estatistica(time_selecionado_id)

    if not estatisticas.empty:
        st.markdown(f"## Estatísticas do {time_selecionado_nome}")
        time_data = estatisticas.iloc[0]

        st.markdown("### Desempenho em casa")
        saldo_gols_casa = time_data["gols_marcados_em_casa"] - time_data["gols_sofridos_em_casa"]
        saldo_gols_fora = time_data["gols_marcados_fora"] - time_data["gols_sofridos_fora"]
        col1, col2, col3 = st.columns(3)
        with col1:
            st.metric("Gols marcados em casa", int(time_data["gols_marcados_em_casa"]))
            st.metric("Gols sofridos em casa", int(time_data["gols_sofridos_em_casa"]))
            st.metric("Vitórias em casa", int(time_data["vitorias_em_casa"]))
            st.metric("Jogos em casa", int(time_data["jogos_em_casa"]))
            st.metric("Saldo de gols (casa)", saldo_gols_casa)
            st.metric("Pontos conquistados em casa", int(time_data["pontos_em_casa"]))
        with col2:
            st.metric("Médias de Gols em casa", int(time_data["media_gols_marcados_em_casa"]))
            st.metric("Médias Gols sofridos em casa", int(time_data["media_gols_sofridos_em_casa"]))
            st.metric("Percentual vitórias em casa", f"{time_data['percentual_vitorias_em_casa']:.1f}%")
            st.metric("Jogos sem sofrer gols (casa)", int(time_data["jogos_sem_sofrer_gol_casa"]))
            st.metric("Tempo médio do primeiro gol (casa)", "####")
            st.metric("Tempo médio do último gol (casa)", "####")
        with col3:
            st.metric("Maior vitória (casa)", (time_data["maior_vitoria_casa"]))
            st.metric("Maior derrota (casa)", (time_data["maior_derrota_casa"]))
            st.metric("Últimos 5 jogos (casa)", "####")  # Exemplo: V V E D V
        st.markdown("---")

        st.markdown("### Desempenho fora de casa")
        col4, col5, col6 = st.columns(3)
        with col4:
            st.metric("Gols marcados (fora)", int(time_data["gols_marcados_fora"]))
            st.metric("Gols sofridos (fora)", int(time_data["gols_sofridos_fora"]))
            st.metric("Vitórias fora", int(time_data["vitorias_fora"]))
            st.metric("Jogos fora", int(time_data["jogos_fora"]))
            st.metric("Saldo de gols (fora)", saldo_gols_fora)
            st.metric("Pontos conquistados fora", int(time_data["pontos_fora"]))
        with col5:
            st.metric("Médias de Gols fora", int(time_data["media_gols_marcados_fora"]))
            st.metric("Médias de Gols sofrido fora", f"{time_data['media_gols_sofridos_fora']:.1f}")
            st.metric("Percentual vitórias (fora)", f"{time_data['percentual_vitorias_fora']:.1f}%")
            st.metric("Jogos sem sofrer gols (fora)", int(time_data["jogos_sem_sofrer_gol_fora"]))
            st.metric("Tempo médio do primeiro gol (fora)", "####")
            st.metric("Tempo médio do último gol (fora)", "####")
        with col6:
            st.metric("Maior vitória (fora)", (time_data["maior_vitoria_fora"]))
            st.metric("Maior derrota (fora)", (time_data["maior_derrota_fora"]))
            st.metric("Últimos 5 jogos (fora)", "####")
        st.markdown("---")

        st.markdown("### Consolidado geral")
        col7, col8, col9 = st.columns(3)
        with col7:
            st.metric("Saldo de gols total", saldo_gols_casa + saldo_gols_fora)
            st.metric("Pontos totais conquistados", int(time_data["pontos_em_casa"] + time_data["pontos_fora"]))
            st.metric("Média de gols marcados (total)", int(time_data["media_gols_marcados_em_casa"] + time_data["media_gols_marcados_fora"]))
            st.metric("Média de gols sofridos (total)", int(time_data["media_gols_sofridos_em_casa"] + time_data["media_gols_sofridos_fora"]))
            st.metric("Jogos sem sofrer gols (total)", int(time_data["jogos_sem_sofrer_gol_casa"] + time_data["jogos_sem_sofrer_gol_fora"]))
        with col8:
            st.metric("Maior vitória (temporada)", (time_data["maior_vitoria"]))
            st.metric("Maior derrota (temporada)", (time_data["maior_derrota"]))
            st.metric("Sequência atual (últimos 5 jogos)", "####")
        with col9:
            st.metric("Tempo médio do primeiro gol (total)", "####")
            st.metric("Tempo médio do último gol (total)", "####")

        st.markdown("---")
        st.write(partidas)
        st.info("Esses dados são calculados a partir das partidas armazenadas no banco.")
    else:
        st.warning("Não foi possível encontrar estatísticas para esse time.")

# Função para análise de desempenho dos times
def analise_desempenho_times(analise):
    # Aqui você pode carregar e preparar os dados, por exemplo:
    st.subheader('Desempenho dos Times')

    performance_df = analise.desempenho_casa_fora()
    # Exibir dados tabulares
    st.write(performance_df)
    

# Função para análise de resultados por rodada
def analise_resultados_rodada():
    st.subheader('Resultados por Rodada')
    # Exemplo de gráfico de gols por rodada
    # df_rodadas = df_matches.groupby('matchday')['home_team_score'].sum()
    # st.line_chart(df_rodadas)

    st.write("Aqui entra o gráfico de resultados por rodada")

# Função para análise de distribuição de gols
def distribuicao_gols():
    st.subheader('Distribuição de Gols')
    # Exemplo de gráfico de distribuição de gols ao longo da partida
    # df_gols = df_matches['home_team_score'] + df_matches['away_team_score']
    # sns.histplot(df_gols, kde=True)
    # st.pyplot()

    st.write("Aqui entra o gráfico de distribuição de gols")

# Função para comparação entre times
def comparacao_times():
    st.subheader('Comparação entre Times')
    # Exemplo de comparação de desempenho de times
    # df_comparacao = df_matches.groupby(['home_team', 'away_team'])['home_team_score'].mean()
    # st.bar_chart(df_comparacao)

    st.write("Aqui entra a comparação entre times")

# Função para análise de tendências
def analise_tendencias():
    st.subheader('Análise de Tendências')
    # Exemplo de análise de tendência (ex: gols marcados no primeiro tempo, segundo tempo)
    # df_tendencias = df_matches.groupby('matchday')['home_team_score'].mean()
    # st.line_chart(df_tendencias)

    st.write("Aqui entra a análise de tendências")

if __name__ == "__main__":
    main()
