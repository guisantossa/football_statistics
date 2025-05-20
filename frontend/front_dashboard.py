import streamlit as st
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.spark_manager import SparkManager
from frontend.front_statistcs import FootballDashboardStatistcs
from frontend.front_classification import FootballDashboardClassification
from frontend.front_ml import FootballDashboardML
import importlib


class FootballDashboard(FootballDashboardStatistcs, FootballDashboardClassification, FootballDashboardML):
    
    def __init__(self):
        FootballDashboardStatistcs.__init__(self)
        FootballDashboardClassification.__init__(self)
        FootballDashboardML.__init__(self)
        self.spark = SparkManager()
        self._reload_spark_module()
    
    def _reload_spark_module(self):
        """Recarrega o módulo FootballAnalytics e recria a instância"""
        importlib.invalidate_caches()  # Limpa cache de imports
        if 'Core.football_analytics' in sys.modules:
            importlib.reload(sys.modules['Core.football_analytics'])
        from Core.football_analytics import FootballAnalytics
        self.spark = FootballAnalytics()
    
    def render_league_selector(self, season=False):
        '''Renderiza os filtros de País, Liga e, opcionalmente, Temporada.'''
        st.sidebar.title("Filtros")
        # 1. Autocomplete para Países
        df_leagues = self.spark.load_leagues().collect()
        countries = list(set([row["country_name"] for row in df_leagues]))
        
        selected_country = st.sidebar.selectbox(
            "País",
            options=countries,
            index=None,
            placeholder="Digite para buscar...",
            key="country_select"
        )
        
        if not selected_country:
            return (None, None, None, None) if season else (None, None, None)
        
        leagues = [row for row in df_leagues if row["country_name"] == selected_country]
        selected_league = st.sidebar.selectbox(
            "Selecione a Liga",
            options=[row["league_name"] for row in leagues],
            index=None,
            placeholder="Digite para buscar..."
        )
        if not selected_league:
            return (None, None, None, None) if season else (None, None, None)
    
        # 4. Obtém ID e nome da liga
        league_info = next(
            (row for row in leagues if row["league_name"] == selected_league),
            None
        )
        
        if not league_info:
            return (None, None, None, None) if season else (None, None, None)
        
        if season:
            # 4. Carrega temporadas da liga
            df_seasons = self.spark.load_seasons_by_league(league_info["id"]).collect()
            season_options = sorted(df_seasons, key=lambda x: x["year"], reverse=True)
            
            selected_season = st.sidebar.selectbox(
                "Temporada",
                options=[row["year"] for row in season_options],
                index=0 if season_options else None,
                placeholder="Selecione a temporada"
            )

            if not selected_season:
                return None, None, None, None

            season_info = next((row for row in season_options if row["year"] == selected_season), None)
            return league_info["id"], league_info["league_name"], selected_country, season_info["id"]

        return league_info["id"], league_info["league_name"], selected_country
                   
    def run(self):
                    
        if "main_section" not in st.session_state:
            st.session_state.main_section = None

        st.title("⚽ Football Statistics Dashboard")
        st.markdown("### Escolha o que deseja visualizar:")

        col1, col2, col3 = st.columns(3)

        with col1:
            if st.button("📊 Estatísticas"):
                st.session_state.main_section = "estatisticas"

        with col2:
            if st.button("📈 Classificações e Rodadas"):
                st.session_state.main_section = "classificacao"

        with col3:
            if st.button("🔮 Previsibilidade"):
                st.session_state.main_section = "previsibilidade"
        
        # Após escolha, renderiza a seção correspondente
        section = st.session_state.main_section

        if section == "estatisticas":
            league_id, league_name, country = self.render_league_selector()
            if not all([league_id, league_name, country]):
                st.info("Selecione um país e uma liga para visualizar os dados")
                return
            self.render_teams_table(league_id, league_name)

        elif section == "classificacao":
            league_id, league_name, country, season_id = self.render_league_selector(season = True)
            if not all([league_id, league_name, country, season_id]):
                st.info("Selecione um país e uma liga para visualizar os dados")
                return
            self.render_leagues_data(league_id, league_name, season_id)

        elif section == "previsibilidade":
            st.subheader("🔮 Escolha o tipo de análise")
            col_pred, col_apostas = st.columns(2)
            
            with col_pred:
                if st.button("📅 Buscar previsões por data", key="btn_pred_por_data"):
                    st.session_state.prediction_mode = "data"

            with col_apostas:
                if st.button("🎯 Gerar sugestões de apostas", key="btn_gerar_apostas"):
                    st.session_state.prediction_mode = "apostas"
            
            
            if "prediction_mode" in st.session_state:
                if st.session_state.prediction_mode == "data":
                    selected_date = st.sidebar.date_input("📅 Escolha a data para previsões", key="prediction_date")
                    if selected_date:
                        self.render_matches_by_date(selected_date)

                elif st.session_state.prediction_mode == "apostas":
                    
                    self.load_mode_apostas()
                    
    
     
    def render_matches_by_date(self, selected_date):
        '''Retorna todas as partidas da data em questão com suas previsões'''
        matches = self.spark.get_matches_per_date_complete(data=selected_date)

        if not matches:
            st.warning(f"⚠️ Nenhum jogo encontrado para {selected_date.strftime('%d/%m/%Y')}")
            return

        st.markdown(f"### 📅 Jogos de {selected_date.strftime('%d/%m/%Y')} ({len(matches)}) ")

        for jogo in matches:
            match_data = {
                "id": jogo["match_id"],
                "league_id": jogo["league_id"],
                "league_name": jogo["league_name"],
                "home_id": jogo["home_team_id"],
                "away_id": jogo["away_team_id"],
                "data": jogo["match_date"],
                "home_team": jogo["home_team"],
                "away_team": jogo["away_team"],
                "home_team_goals": jogo.get("home_team_goals"),
                "away_team_goals": jogo.get("away_team_goals"),
            }
            self.render_match_card(match_data, show='ML')
    
    def render_match_card(self, match: dict, show: str = None):
        '''Renderiza um cartão individual de partida'''
        date = match["data"].strftime("%d/%m/%Y")
        location = "Em casa" if match.get("location") == "home" else "Fora"
        #location = "Em casa" if match["location"] == "home" else "Fora"
        result = f"{match['home_team_goals']} x {match['away_team_goals']}" if match.get("home_team_goals") is not None else "x"
        if "home_team" in match:
            home_team = match["home_team"]
            
        away_team = match["away_team"]
        

        if(show == 'statistics'):
            with st.expander(f"📅 {date} - {location} - vs **{away_team}** ({result})"):
                self.render_match_statistics(match["id"])
        elif(show == 'ML'):
            with st.expander(f"📅 {match['data']} - {match['home_team']} vs {match['away_team']}"):
                self.render_predictions(match['id'])
        else:
            st.markdown(f"📅 {date} - {home_team} - vs {away_team}")             

    def render_next_round(self, league_id, league_name):
        """Renderiza a próxima rodada da liga com cards de jogos."""
        matches = self.spark.get_todays_matches(league_id=league_id)

        if not matches :
            st.warning("Não há rodadas disponíveis para essa liga/temporada.")
            return None

        st.markdown(f"### 📅 Jogos da rodada {matches[0]['matchday']} - {league_name}")

        for jogo in matches:
            match_data = {
                "id": jogo["match_id"],
                "league_id": jogo["league_id"],
                "home_id": jogo["home_team_id"],
                "away_id": jogo["away_team_id"],
                "data": jogo["match_date"],
                "location": "home",  # ou lógica extra para saber quem joga em casa
                "home_team": jogo["home_team"],
                "away_team": jogo["away_team"],
                "home_team_goals": jogo["home_team_goals"],
                "away_team_goals": jogo["away_team_goals"]
            }
            self.render_match_card(match_data, show='ML')
    
    '''
    A partir daqui são metodos do ML a serem copiados para outro arquivo
    '''
    


    def modal_render_ultimos_jogos(self, match_id: int):
        '''Modal para exibição dos últimos jogos'''
        from streamlit_modal import Modal
        modal_key = f"modal_{match_id}"

        # Cria o modal com uma chave única
        modal = Modal(
            title=f"Últimos jogos - Partida {match_id}",
            key=f"mod_{match_id}",
            # Opcional: definir tamanho do modal
            max_width="800px"
        )
        
        # Abre o modal
        modal.open()
        # Abre o modal apenas se o estado estiver True
        if modal.is_open():
            with modal.container():
                st.markdown(f"## Análise dos últimos jogos - Partida {match_id}")
                
                # Conteúdo do modal em colunas
                col1, col2 = st.columns(2)
                
                with col1:
                    st.markdown("### Time da Casa")
                    # Adicione aqui os dados do time da casa
                    # Exemplo: st.write(self.get_last_games(home_team_id))
                    
                with col2:
                    st.markdown("### Time Visitante")
                    # Adicione aqui os dados do time visitante
                
                # Botão para fechar o modal
                if st.button("Fechar", key=f"close_{match_id}"):
                    st.session_state[f"modal_{match_id}"] = False
                    st.experimental_rerun()
                
                
    