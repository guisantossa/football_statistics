import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder, GridUpdateMode
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.football_ml import MatchProbabilityPredictor
import pandas as pd
from decimal import Decimal

class FootballDashboardML():
    
    def __init__(self):
        self.spark_ml = MatchProbabilityPredictor()
        
    def load_mode_apostas(self):
        st.markdown("### 🎛️ Filtros de geração")
        from datetime import date
        
        col1, col2, col3 = st.columns(3)
        with col1:
            odd_min = st.number_input("Odd mínima Acumulada", min_value=1.0, max_value=100.0, step=0.1, value=1.15)
        with col2:
            odd_max = st.number_input("Odd máxima Acumulada", min_value=1.0, max_value=100.0, step=0.1, value=1.40)
        with col3:
            save_to_db = st.checkbox("Salvar no banco?", value=False)

        col4, col5, col6 = st.columns(3)
        with col4:
            num_bets = st.number_input("Número de apostas por combinação", min_value=1, max_value=20, step=1, value=2)
        with col5:
            max_repetitions = st.number_input("Máximo de repetições por aposta", min_value=1, max_value=10, step=1, value=2)
        with col6:
            date_filter = st.date_input("Data", value=date.today())
            
        col7, col8, col9 = st.columns(3)
        with col7:
            min_odd_individual = st.number_input("Odd Minima Individual", min_value=1.05, max_value=3.0, step=0.01, value=1.10)
        with col8:
            prob = st.number_input("Probabilidade Individual", min_value=0.7, max_value=1.0, step=0.05, value=0.80)
        with col9:
            confianca = st.number_input("Confiança Individual", min_value=0.5, max_value=1.0, step=0.05, value=0.80)
        col10, col11, col12 = st.columns(3)
        with col10:
            max_combination = st.number_input("Número de Combinações Máxima", min_value=10, max_value=1000, step=10, value=50)
        with col11:
            filtro_jogos = st.selectbox(
                "Filtrar jogos do dia",
                options=["Incluir todos", "Excluir alguns", "Selecionar manualmente"]
            )
            
        
        
        def formatar_jogos_para_display(jogos):
            return [
                {
                    "id": jogo['match_id'],
                    "label": f"{jogo['home_team']} x {jogo['away_team']} | {jogo['league_name']} | {jogo['match_date'].strftime('%H:%M')}"
                }
                for jogo in jogos
            ]
        jogos_excluidos = []
        jogos_incluidos = []
        
        if filtro_jogos in ["Excluir alguns", "Selecionar manualmente"]:
            jogos_raw = self.spark_ml.get_matches_per_date_complete(date_filter)
            jogos_formatados = formatar_jogos_para_display(jogos_raw)
            opcoes_display = [j["label"] for j in jogos_formatados]

            if filtro_jogos == "Excluir alguns":
                jogos_excluidos_display = st.multiselect("Selecione os jogos que deseja **excluir**:", opcoes_display)
                jogos_excluidos = [j["id"] for j in jogos_formatados if j["label"] in jogos_excluidos_display]

            elif filtro_jogos == "Selecionar manualmente":
                jogos_incluidos_display = st.multiselect("Selecione os jogos que deseja **incluir**:", opcoes_display)
                jogos_incluidos = [j["id"] for j in jogos_formatados if j["label"] in jogos_incluidos_display]

        if st.button("🚀 Gerar Apostas", key="btn_final_gerar"):
            self.generate_bet_suggestions(
                date_filter, odd_min, odd_max, num_bets, max_repetitions, min_odd_individual, prob, confianca, save_to_db, max_combination,jogos_excluidos=jogos_excluidos, 
                jogos_incluidos=jogos_incluidos
            )
            
    def generate_bet_suggestions(self, data, odd_min, odd_max, num_bets, max_repetitions, min_odd_individual, prob, confianca, save, max_combination, jogos_excluidos, jogos_incluidos):
        st.markdown("### 🧪 Gerando combinações de apostas...")

        try:
            # Gera as apostas como uma lista de dicionários
            bets_list = self.spark_ml.generate_combinations_bets(
                data=data,
                odd_min=min_odd_individual,
                prob=prob,
                confianca=confianca,
                min_odds=odd_min,
                max_odds=odd_max,
                num_bets=num_bets,
                max_repeats_per_bet=max_repetitions,
                top_n=max_combination,
                jogos_excluidos=jogos_excluidos, 
                jogos_incluidos=jogos_incluidos
            )
            
            if not bets_list:
                st.warning("⚠️ Nenhuma aposta encontrada com os critérios definidos.")
                return
            if save == True:
                try:
                    result = self.spark_ml.save_combinations_to_db(
                        bets_list, odd_min, odd_max
                    )
                    st.success("✅ Apostas salvas com sucesso!")

                    if result.get("errors"):
                        st.warning("⚠️ Algumas partidas não estavam cadastradas:")
                        for msg in result["errors"]:
                            st.markdown(f"- {msg}")
                except Exception as e:
                    st.error("❌ Erro ao salvar apostas:")
                    st.code(str(e))
                    
            st.success(f"✅ {len(bets_list)} combinações encontradas!")
            st.markdown("### 🧾 Apostas sugeridas")


            for  combo in bets_list:
                st.markdown(f"### 🎯 Combinação #{combo.get('combination_id')}")
                st.markdown(f"**💰 Odds Total:** `{combo['total_odds']:.2f}`")
                st.markdown(
                    f"**📊 Probabilidade Média:** `{combo['avg_probability']:.2%}` &nbsp;&nbsp;&nbsp; "
                    f"**🧠 Confiabilidade Média:** `{combo['avg_confidence']:.2%}` &nbsp;&nbsp;&nbsp; "
                    f"**🧾 Número de Apostas:** `{len(combo['bets'])}` "
                )

                with st.expander("👁️ Ver apostas dessa combinação"):
                    for bet in combo['bets']:
                        st.markdown(
                            f"- **{bet['match']}**: {bet['bet']} "
                            f"(🎯 Odd: `{bet['odd']:.2f}`, 🔢 Prob: `{bet['prob']:.2%}`, 🧠 Conf: `{bet['confianca']:.2%}`)"
                        )

                st.markdown("---")
            

            
            
                        
        
        except Exception as e:
            st.error(f"❌ Erro ao gerar apostas: {e}")

    def render_predictions(self, match_id: int):
        '''Renderiza as previsões'''
        st.markdown("## 📊 Previsões das Partidas")
        
        
            
        predictions = self.spark_ml.get_predictions_matches(match_id)
        available_bet_types = sorted(list(set(p["bet_type"].capitalize() for p in predictions)))
        
        selected_bet_types = st.multiselect(
            "Filtrar por tipo de aposta:",
            available_bet_types,
            default=available_bet_types,
            key=f"bet_filter_{match_id}"  # chave única por partida
        )
        confidence_range = st.slider(
            "Filtrar por nível de confiabilidade (%):",
            min_value=50,
            max_value=100,
            step=10,
            value=(50, 100),  # valor inicial (range inteiro)
            key=f"confidence_filter_{match_id}"
        )
        filtered_predictions = [
            p for p in predictions
            if p["bet_type"].capitalize() in selected_bet_types
            and (confidence_range[0] <= p["confianca"] * 100 <= confidence_range[1])
        ]
        for predict in predictions:
            if (
                predict["bet_type"].capitalize() in selected_bet_types
                and (confidence_range[0] <= predict["confianca"] * 100 <= confidence_range[1])
            ):
                match_data = {
                    "id": predict["match_id"],
                    "home_id": predict["home_id"],
                    "away_id": predict["away_id"],
                    "home_team": predict["home"],
                    "away_team": predict["away"],
                    "home_rank": predict["home_team_rank"],
                    "away_rank": predict["away_team_rank"],
                    "bet_type": predict["bet_type"],
                    "valor": predict["valor"],
                    "probabilidade": predict["probabilidade"],
                    "confianca": predict["confianca"]*100,
                    "league": predict["league"]
                }
            
                with st.container():
                    # Exemplo simples de HTML no Streamlit
                    
                    st.markdown(f"""
                        <div style="white-space: nowrap; overflow-x: auto; padding: 4px 0; display: flex; align-items: center; justify-content: flex-start; gap: 10px;">
                            <!-- Elementos em uma única linha com espaço adequado -->
                            <span style="display: inline-block; width: 10%; font-size: 12px; background-color: #f0f4f8; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                🏆 <strong>{match_data["league"]}</strong>
                            </span>
                            <span style="display: inline-block; width: 30%; font-size: 12px; background-color: #f0f4f8; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                ⚔️ <strong>{match_data["home_team"]}</strong> <span style="color: #666;">(#{match_data["home_rank"]})</span> vs <strong>{match_data["away_team"]}</strong> <span style="color: #666;">(#({match_data["away_rank"]}))</span>
                            </span>
                            <span style="display: inline-block; width: 25%; font-size: 12px; background-color: #e6f0fa; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                💡 <strong>{match_data["bet_type"].capitalize()}</strong>
                            </span>
                            <span style="display: inline-block; width: 15%; font-size: 12px; background-color: #e8f8f5; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                🎯 <strong>{match_data["valor"]}</strong>
                            </span>
                            <span style="display: inline-block; width: 10%; font-size: 12px; background-color: #fef9e7; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                📊 <strong>{match_data["probabilidade"]*100:.1f}%</strong>
                            </span>
                            <span style="display: inline-block; width: 10%; font-size: 12px; background-color: {'#eafaf1' if match_data['confianca'] >= 70 else '#fff8e1' if match_data['confianca'] >= 50 else '#fdedec'}; padding: 4px 8px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                🔒 <strong style="color: {'#27ae60' if match_data['confianca'] >= 70 else '#f39c12' if match_data['confianca'] >= 50 else '#e74c3c'}">{match_data['confianca']:1f}%</strong>
                            </span>
                        </div>

                        """, unsafe_allow_html=True) 
