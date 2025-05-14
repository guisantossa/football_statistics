from streamlit import session_state
from utils.data_loader import load_matches, load_players

def init_global_state():
    """Carrega dados na sessão uma única vez."""
    if "matches_df" not in session_state:
        session_state.matches_df = load_matches()  # DataFrame de partidas (com cache)
    if "players_df" not in session_state:
        session_state.players_df = load_players()  # DataFrame de jogadores
    if "filters" not in session_state:
        session_state.filters = {"league": "Brasileirão", "season": 2024}  # Filtros padrão