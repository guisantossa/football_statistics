import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder, GridUpdateMode
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.football_classification import FootballClassification
import pandas as pd


class FootballDashboardClassification():
    
    def __init__(self):
        self.spark_classification = FootballClassification()
    
    def render_leagues_data(self, league_id, league_name, season_id):
        '''
            Renderiza a classificação dos times e os dados da tabela
        '''
        st.title(f"🏆 Classificação da {league_name}")
        league_data = self.spark_classification.get_league_classification(league_id, season_id)
        if not league_data:
            st.warning("Nenhum time encontrado para esta liga")
            return
        
        # Transforma em DataFrame
        df = pd.DataFrame(league_data)
        
        # Configuração simplificada das colunas
        cols_to_show = [
            'time', 'jogos', 'vitorias', 'empates',
            'derrotas', 'gols_pro', 
            'gols_contra', 'saldo',
            'pontos'
        ]
        
        # Renomeia colunas
        renamed_cols = {
            'time': 'Time',
            'jogos': 'Jogos',
            'vitorias': 'Vitórias',
            'empates': 'Empates',
            'derrotas': 'Derrotas',
            'gols_pro': 'Gols Pró',
            'gols_contra': 'Gols Contra',
            'saldo': 'Saldo',
            'pontos': 'Pontos'
        }
        
        
        df_display = df[cols_to_show].rename(columns=renamed_cols)
        
        gb = GridOptionsBuilder.from_dataframe(df_display)
        gb.configure_selection('single', use_checkbox=False, pre_selected_rows=[])
        gb.configure_grid_options(domLayout='normal')
        grid_options = gb.build()
        
        grid_response = AgGrid(
            df_display,
            gridOptions=grid_options,
            update_mode=GridUpdateMode.SELECTION_CHANGED,
            theme='streamlit',  # Outros temas: 'light', 'dark', 'blue', etc.
            fit_columns_on_grid_load=True,
            height=600,
            width='100%'
        )
        self.render_rounds(league_id, season_id)
        
    def render_rounds(self, league_id, season_id):
        """Renderiza o seletor de rodada com base na liga e temporada fornecidas."""
        df_rounds = self.spark_classification.get_rounds(league_id=league_id, season_id=season_id)

        if not df_rounds:
            st.warning("Não há rodadas disponíveis para essa liga/temporada.")
            return None

        df = pd.DataFrame(df_rounds)
        today = pd.Timestamp.now().normalize()
        df['diff'] = abs(df['match_date'] - today)
        df_sorted = df.sort_values(by='diff')
        default_round = df_sorted.iloc[0]['matchday']
        matchdays = sorted(df['matchday'].dropna().unique().tolist())
        # Garante que o valor default esteja na lista, senão usa índice 0 como fallback
        if default_round in matchdays:
            default_index = matchdays.index(default_round)
        else:
            default_index = 0
            
        selected_round = st.sidebar.selectbox(
            "Rodada",
            options=matchdays,
            index=default_index,
            key="round_select"
        )

        st.markdown(f"### 📅 Jogos da rodada {selected_round}")
        jogos_da_rodada = [match for match in df_rounds if match["matchday"] == selected_round]

        for jogo in jogos_da_rodada:
            match_data = {
                "id": jogo["match_id"],
                "data": jogo["match_date"],
                "location": "home",  # ou lógica extra para saber quem joga em casa
                "home_team": jogo["home_team"],
                "away_team": jogo["away_team"],
                "home_team_goals": jogo["home_team_goals"],
                "away_team_goals": jogo["away_team_goals"]
            }
            self.render_match_card(match_data)
    
    
        
    
        
    