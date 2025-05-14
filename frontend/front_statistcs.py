import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder, GridUpdateMode
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.football_analytics import FootballAnalytics
import pandas as pd
from decimal import Decimal


class FootballDashboardStatistcs():
    
    def __init__(self):
        self.spark_statistics = FootballAnalytics()
    
    def render_teams_table(self, league_id: int, league_name: str):
        """Tabela de times com seleção por clique na linha"""
        st.title(f"🏆 Times da {league_name}")
        selected_rows = 0
        teams_stats = self.spark_statistics.get_teams_stats_by_league(league_id)
        if not teams_stats:
            st.warning("Nenhum time encontrado para esta liga")
            return
        
        # Transforma em DataFrame
        df = pd.DataFrame(teams_stats)
        
        # Configuração simplificada das colunas
        cols_to_show = [
            'name', 'total_matches', 'wins', 'win_percentage',
            'avg_goals_scored', 'avg_goals_conceded', 
            'avg_possession', 'shot_accuracy',
            'avg_shots', 'avg_shots_on_target',
            'total_yellow_cards', 'total_red_cards'
        ]
        
        # Renomeia colunas
        renamed_cols = {
            'name': 'Time',
            'total_matches': 'Jogos',
            'wins': 'Vitórias',
            'win_percentage': '% Vitórias',
            'avg_goals_scored': 'Gols (Média)',
            'avg_goals_conceded': 'Gols Sofridos (Média)',
            'avg_possession': 'Posse (%)',
            'shot_accuracy': 'Precisão (%)',
            'avg_shots': 'Finalizações (Média)',
            'avg_shots_on_target': 'Finalizações Certas (Média)',
            'total_yellow_cards': 'Cartões Amarelos',
            'total_red_cards': 'Cartões Vermelhos'
        }
        
        # Configuração de formatação separada
        column_config = {
            "% Vitórias": st.column_config.NumberColumn(format="%.1f%%"),
            "Posse (%)": st.column_config.NumberColumn(format="%.1f%%"),
            "Precisão (%)": st.column_config.NumberColumn(format="%.1f%%"),
            "Gols (Média)": st.column_config.NumberColumn(format="%.2f"),
            "Finalizações (Média)": st.column_config.NumberColumn(format="%.1f")
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
        
        selected_rows_raw = grid_response['selected_rows']
        # Converte para lista de dicionários se for DataFrame
        if isinstance(selected_rows_raw, pd.DataFrame):
            selected_rows = selected_rows_raw.to_dict('records')
        else:
            selected_rows = selected_rows_raw

        if len(selected_rows) > 0:
            selected_row = selected_rows[0]
            selected_index = df_display[df_display['Time'] == selected_row['Time']].index[0]
            team_id = df.iloc[selected_index]['id']
            team_name = df.iloc[selected_index]['name']
            st.success(f"Time selecionado: {team_name}")
            next_match = self.render_next_match(team_id)
            self.render_latest_matches(next_match, 5)
            
    def render_latest_matches(self, next_match, matches_limit:int = 5):
        '''Renderiza as ultimas partidas dos times selecionados'''
        st.markdown("### 📌 Últimos jogos recentes")
        col1, col2 = st.columns(2)
        home_team_matches = self.spark_statistics.get_latest_matches(next_match['home_id'],matches_limit)
        away_team_matches = self.spark_statistics.get_latest_matches(next_match['away_id'],matches_limit)
        
        with col1:
            st.markdown(f"**{next_match['home_team']}**")
            for match in home_team_matches:
                self.render_match_card(match, show='statistics')

        with col2:
            st.markdown(f"**{next_match['away_team']}**")
            for match in away_team_matches:
                self.render_match_card(match, show='statistics')
                
    def render_match_statistics(self, match_id: int):
        '''Renderiza as estatisticas do jogo em questão'''
        home_stats, away_stats = self.spark_statistics.get_match_statistics(match_id = match_id)

        if not home_stats or not away_stats:
            st.info("Sem estatísticas disponíveis para esta partida.")
            return

        self.render_stats_table(home_stats, away_stats) 
        
    def render_stats_table(self, home_stats: dict, away_stats: dict):
        '''Renderiza estatísticas do jogo com destaque e sugestões inteligentes de aposta'''
        st.subheader("📊 Estatísticas Recentes")

        stats_labels = {
            "avg_goals": "Gols",
            "avg_possession": "Posse de Bola (%)",
            "avg_shots": "Chutes",
            "avg_shots_on_target": "Chutes no Alvo",
            "avg_fouls": "Faltas",
            "avg_corners": "Escanteios",
            "avg_yellow_cards": "Cartões Amarelos",
            "avg_red_cards": "Cartões Vermelhos",
            "avg_firsthalf_goals": "Gols no 1º Tempo"
        }

        table_data = []
        for key, label in stats_labels.items():
            home_val = home_stats.get(key, 0) or 0
            away_val = away_stats.get(key, 0) or 0

            if isinstance(home_val, Decimal): home_val = float(home_val)
            if isinstance(away_val, Decimal): away_val = float(away_val)
            if isinstance(home_val, str) and "%" in home_val: home_val = home_val.replace("%", "")
            if isinstance(away_val, str) and "%" in away_val: away_val = away_val.replace("%", "")

            table_data.append([label, home_val, away_val])

        df = pd.DataFrame(table_data, columns=["Estatística", "Casa", "Visitante"])

        def apply_highlight(row):
            styles = ["", "", ""]
            key = row["Estatística"]
            home_val = row["Casa"]
            away_val = row["Visitante"]
            invert = key in {"Cartões Amarelos", "Cartões Vermelhos", "Faltas"}
            if invert:
                better = home_val < away_val
            else:
                better = home_val > away_val
            if better:
                styles[1] = "color: #0d6efd; font-weight: bold;"
            elif home_val != away_val:
                styles[2] = "color: #ff6600; font-weight: bold;"
            return styles

        styled_df = df.style.apply(apply_highlight, axis=1)
        st.dataframe(styled_df, use_container_width=True, hide_index=True)
        '''
        # Sugestões automáticas
        with st.container():
            st.markdown("### 🎯 Sugestões de Aposta Inteligente")

            sugestoes = self.generate_bet_suggestions(home_stats, away_stats)
            self.render_bet_suggestions(sugestoes)
        '''
    
    def _render_stats_table(self, home_stats: dict, away_stats: dict):
        '''Renderiza as estatísticas do jogo com destaque para quem teve melhor desempenho'''
        st.subheader("📊 Estatísticas Recentes")

        stats_labels = {
            "avg_goals": "Gols",
            "avg_possession": "Posse de Bola (%)",
            "avg_shots": "Chutes",
            "avg_shots_on_target": "Chutes no Alvo",
            "avg_fouls": "Faltas",
            "avg_corners": "Escanteios", 
            "avg_yellow_cards": "Cartões Amarelos",
            "avg_red_cards": "Cartões Vermelhos",
            "avg_firsthalf_goals": "Gols no 1º Tempo"
        }

        # Dados formatados para tabela
        table_data = []
        
        for key, label in stats_labels.items():
            home_val = home_stats.get(key, 0) or 0
            away_val = away_stats.get(key, 0) or 0
            
            # Conversão de tipos
            if isinstance(home_val, Decimal):
                home_val = float(home_val)
            if isinstance(away_val, Decimal):
                away_val = float(away_val)
            
            # Remove % se existir
            if isinstance(home_val, str) and "%" in home_val:
                home_val = home_val.replace("%", "")
            if isinstance(away_val, str) and "%" in away_val:
                away_val = away_val.replace("%", "")
            
            table_data.append([label, home_val, away_val])

        # Cria DataFrame
        df = pd.DataFrame(table_data, columns=["Estatística", "Casa", "Visitante"])
        
        # Função para aplicar estilo
        def apply_highlight(row):
            styles = ["", "", ""]
            key = row["Estatística"]
            home_val = row["Casa"]
            away_val = row["Visitante"]
            
            invert = key in {"avg_yellow_cards", "avg_red_cards", "avg_fouls"}
            
            if invert:
                better = home_val < away_val
            else:
                better = home_val > away_val
            
            if better:
                styles[1] = "color: #0d6efd; font-weight: bold;"
            elif home_val != away_val:
                styles[2] = "color: #ff6600; font-weight: bold;"
                
            return styles

        # Aplica o estilo
        styled_df = df.style.apply(apply_highlight, axis=1)
        
        # Exibe a tabela
        st.dataframe(styled_df, use_container_width=True, hide_index=True)
    
    def render_stats_bar(self, home_stats: dict, away_stats: dict):
        '''Renderiza as estatisticas do jogo selecionado'''
        st.subheader("📊 Estatísticas Recentes")

        stats_labels = {
            "avg_goals": "Goals",
            "avg_possession": "Ball Possession",
            "avg_shots": "Shots",
            "avg_shots_on_target": "Shots on Target",
            "avg_fouls": "Fouls",
            "avg_corners": "Corner Kicks", 
            "avg_yellow_cards": "Yellow Cards",
            "avg_red_cards": "Red Cards",
            "avg_firsthalf_goals": "First Half Goals"
        }
        # Normalize os valores para porcentagem para plotar barras proporcionais
        for key, label in stats_labels.items():
            home_val = home_stats.get(key, 0) or 0
            away_val = away_stats.get(key, 0) or 0
            
            # Converte Decimal → float
            if isinstance(home_val, Decimal):
                home_val = float(home_val)
            if isinstance(away_val, Decimal):
                away_val = float(away_val)
            # Converte string com % → int
            if isinstance(home_val, str) and "%" in home_val:
                home_val = int(home_val.strip("%"))
            if isinstance(away_val, str) and "%" in away_val:
                away_val = int(away_val.strip("%"))


            max_val = max(home_val, away_val, 1)  # evita divisão por zero
            home_percent = int((home_val / max_val) * 100)
            away_percent = int((away_val / max_val) * 100)
            
            st.markdown(f"**{label}**")
            st.markdown(f"""
            <div style="margin-bottom: 8px;">
                <div style="display: flex; justify-content: space-between; font-weight: 600; font-size: 14px; margin-bottom: 4px;">
                    <span style="color: #1f77b4;">{home_val}</span>
                    <span style="color: #444;" align='center'>{label}</span>
                    <span style="color: #ff7f0e;">{away_val}</span>
                </div>
                <div style="display: flex; height: 14px; background: #f0f2f6; border-radius: 8px; overflow: hidden;">
                    <div style="width: {home_percent}%; background-color: #1f77b4;"></div>
                    <div style="width: {away_percent}%; background-color: #ff7f0e;"></div>
                </div>
            </div>
        """, unsafe_allow_html=True)
        
    def render_next_match(self, team_id: int):
        """Exibe o próximo jogo do time selecionado"""
        st.divider()
        
        with st.spinner("Buscando próximo jogo..."):
            next_match = self.spark_statistics.get_next_match(team_id)
            
            if next_match:
                st.subheader("⏭️ Próximo Jogo")
                
                col1, col2, col3 = st.columns([1, 0.5, 1])
                with col1:
                    st.markdown(
                        f"""
                        <div style='display: flex; align-items: center; gap: 10px;'>
                            <img src="{next_match['home_logo']}" width="30">
                            <h3 style='margin: 0;'>{next_match['home_team']}</h3>
                        </div>
                        """,
                        unsafe_allow_html=True
                    )
                with col2:
                    st.markdown("### vs")
                with col3:
                    st.markdown(
                        f"""
                        <div style='display: flex; align-items: center; gap: 10px;'>
                            <img src="{next_match['away_logo']}" width="30">
                            <h3 style='margin: 0;'>{next_match['away_team']}</h3>
                        </div>
                        """,
                        unsafe_allow_html=True
                    )
                
                st.caption(f"📅 {next_match['data'].strftime('%d/%m/%Y %H:%M')}")
                # logo após o bloco que mostra a data do jogo
                # Filtros
                limit_options = {
                    "Últimos 5 jogos": 5,
                    "Últimos 10 jogos": 10
                }
                location_options = {
                    "Todos": "all",
                    "Em casa": "home",
                    "Fora": "away"
                }

                col1, col2 = st.columns(2)
                with col1:
                    location_filter = st.selectbox("Mando de Campo", list(location_options.keys()))
                with col2:
                    limit_filter = st.selectbox("Quantidade de Jogos", list(limit_options.keys()))
                # Mapeia os valores dos filtros
                location_value = location_options[location_filter]
                limit_value = limit_options[limit_filter]
                
                home_stats = self.spark_statistics.get_team_statistics(next_match['home_id'], location_value, limit_value)
                away_stats = self.spark_statistics.get_team_statistics(next_match['away_id'], location_value, limit_value)
                
                if home_stats and away_stats:
                    self.render_stats_table(home_stats, away_stats)
                    return next_match
                else:
                    st.warning("Estatísticas dos times não encontradas.")

                
            else:
                st.info("Nenhum jogo futuro agendado para este time") 

        
    