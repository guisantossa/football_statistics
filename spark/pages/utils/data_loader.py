from streamlit import cache_data
import pandas as pd

@cache_data(ttl=3600)  # Cache de 1 hora
def load_matches():
    return pd.read_parquet("../data/matches.parquet")  # Exemplo real

@cache_data
def load_players():
    return pd.read_parquet("../data/matches.parquet")