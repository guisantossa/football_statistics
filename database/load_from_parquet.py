import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from db import Base  # Importe suas classes do modelo aqui

# Configuração da conexão
from dotenv import load_dotenv
import os

# Carregar variáveis do .env
load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)
session = Session()

# Função para carregar Parquet para o banco
def load_parquet_to_db(parquet_path, table_name, chunk_size=1000):
    # Ler arquivo Parquet
    df = pd.read_parquet(parquet_path)
    df = df.drop(columns=['utc_date'])
    
    # Carregar em chunks para evitar sobrecarga de memória
    for i in range(0, len(df), chunk_size):
        chunk = df[i:i + chunk_size]
        chunk.to_sql(
            name=table_name,
            con=engine,
            if_exists='append',  # Adiciona dados à tabela existente
            index=False,
            method='multi'  # Insere múltiplas linhas de uma vez
        )
        print(f"Carregados {min(i + chunk_size, len(df))}/{len(df)} registros")
    
    print(f"Dados de {parquet_path} carregados na tabela {table_name}")

path = r'database/files'


#load_parquet_to_db(os.path.join(path, 'leagues.parquet'), 'leagues')

#load_parquet_to_db(os.path.join(path, 'seasons.parquet'), 'seasons')
#load_parquet_to_db(os.path.join(path, 'season_teams.parquet'), 'season_teams')
#
try:
    load_parquet_to_db(os.path.join(path, 'matches.parquet'), 'matches')
except Exception as e:
    print(f"erro {e}")
    

