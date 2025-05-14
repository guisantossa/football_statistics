from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, DateTime, DECIMAL, Boolean, Numeric, PrimaryKeyConstraint
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.dialects.postgresql import JSON
from datetime import datetime
from dotenv import load_dotenv
import os

# Carregar variáveis do .env
load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")

#criação do Engine
engine = create_engine(DATABASE_URL)

Base = declarative_base()

class Player(Base):
    __tablename__ = 'players'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    position = Column(String(50), nullable=False)
    team_id = Column(Integer, ForeignKey('teams.id'))
    
    team = relationship('Team', back_populates='players')
    statistics = relationship('PlayerStatistic', back_populates='player')

class PlayerStatistic(Base):
    __tablename__ = 'players_statistics'

    id = Column(Integer, primary_key=True)
    player_id = Column(Integer, ForeignKey('players.id'))
    match_id = Column(Integer, ForeignKey('matches.id'))
    minutes = Column(Integer)
    shots = Column(Integer)
    shot_on_target = Column(Integer)
    passes = Column(Integer)
    key_passes = Column(Integer)
    pass_accuracy = Column(DECIMAL(5, 2))
    fouls_drawn = Column(Integer)
    fouls_committed = Column(Integer)
    goals = Column(Integer)
    red_card = Column(Integer)
    yellow_card = Column(Integer)
    
    player = relationship('Player', back_populates='statistics')
    match = relationship('Match', back_populates='statistics')

class Team(Base):
    __tablename__ = 'teams'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    short_name = Column(String, nullable=True)
    city = Column(String(100), nullable=True)
    img_url = Column(String(255))

    players = relationship('Player', back_populates='team')
    team_players = relationship('TeamPlayer', back_populates='team')
    matches_home = relationship('Match', foreign_keys='Match.home_team_id', back_populates='home_team')
    matches_away = relationship('Match', foreign_keys='Match.away_team_id', back_populates='away_team')

class TeamPlayer(Base):
    __tablename__ = 'teams_players'

    team_id = Column(Integer, ForeignKey('teams.id'), primary_key=True)
    player_id = Column(Integer, ForeignKey('players.id'), primary_key=True)

    team = relationship('Team', back_populates='team_players')
    player = relationship('Player')

class Match(Base):
    __tablename__ = 'matches'
    
    id = Column(Integer, primary_key=True)
    data = Column(DateTime, nullable=False)
    
    # Times
    home_team_id = Column(Integer, ForeignKey('teams.id'), nullable=False)
    away_team_id = Column(Integer, ForeignKey('teams.id'), nullable=False)
    
    # Placar
    home_team_goals = Column(Integer)
    away_team_goals = Column(Integer)
    home_team_goals_firsthalf = Column(Integer)
    away_team_goals_firsthalf = Column(Integer)
    
    
    # Estatísticas do Time (Casa)
    home_team_possession = Column(Numeric(5, 2))
    home_team_shots = Column(Integer)
    home_team_shots_on_target = Column(Integer)
    home_team_fouls = Column(Integer)
    home_team_corners = Column(Integer)
    home_team_yellow_cards = Column(Integer)
    home_team_red_cards = Column(Integer)
    
    # Estatísticas do Time (Visitante)
    away_team_possession = Column(Numeric(5, 2))
    away_team_shots = Column(Integer)
    away_team_shots_on_target = Column(Integer)
    away_team_fouls = Column(Integer)
    away_team_corners = Column(Integer)
    away_team_yellow_cards = Column(Integer)
    away_team_red_cards = Column(Integer)
    
    # Metadados
    league_id = Column(Integer, ForeignKey('leagues.id'), nullable=False)
    status = Column(String(1), nullable=False)  # 0=Não jogado, 1=Finalizado, 2=Andamento
    matchday = Column(String(50), nullable=True)  # Ex: "Rodada 1", "Semifinal"
    
    # Classificação no momento da partida
    home_team_rank = Column(Integer)
    away_team_rank = Column(Integer)
    home_team_points = Column(Integer)
    away_team_points = Column(Integer)

    # Gols acumulados antes da partida
    home_team_goals_pro = Column(Integer)
    home_team_goals_against = Column(Integer)
    home_team_goal_diff = Column(Integer)

    away_team_goals_pro = Column(Integer)
    away_team_goals_against = Column(Integer)
    away_team_goal_diff = Column(Integer)

    # Cartões acumulados antes da partida
    home_team_yellow_cards_total = Column(Integer)
    home_team_red_cards_total = Column(Integer)

    away_team_yellow_cards_total = Column(Integer)
    away_team_red_cards_total = Column(Integer)
    
    # Relacionamentos (IMPORTANTE: mantive seus relacionamentos originais)
    home_team = relationship("Team", foreign_keys=[home_team_id], back_populates="matches_home")
    away_team = relationship("Team", foreign_keys=[away_team_id], back_populates="matches_away")
    league = relationship("League", back_populates="matches")
    statistics = relationship("PlayerStatistic", back_populates="match")
    
    
    bets = relationship('Bet', back_populates='match')
    predictions = relationship("Prediction", back_populates="match")
    combination_bets = relationship('CombinationBet', back_populates='matches')

class League(Base):
    __tablename__ = 'leagues'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    type = Column(String(50), nullable=False)
    logo = Column(String(255))
    country_id = Column(Integer, ForeignKey('countries.id'))

    country = relationship('Country', back_populates='leagues')
    matches = relationship('Match', back_populates='league')
    

class BetType(Base):
    __tablename__ = 'bet_types'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)  # Ex: "Match Winner", "Goals Over/Under"
    description = Column(String(255))           # Opcional, mais detalhes

    bets = relationship('Bet', back_populates='bet_type')
    predictions = relationship('Prediction', back_populates='bet_type')

class Bookmaker(Base):
    __tablename__ = 'bookmakers'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    logo_url = Column(String(255))              # Opcional, para exibir em interfaces

    bets = relationship('Bet', back_populates='bookmaker')    

class Bet(Base):
    __tablename__ = 'bets'

    match_id = Column(Integer, ForeignKey('matches.id'), nullable=False)
    bet_type_id = Column(Integer, ForeignKey('bet_types.id'), nullable=False)
    bookmaker_id = Column(Integer, ForeignKey('bookmakers.id'), nullable=False)
    
    bet_value = Column(String(50), nullable=False) # Ex: "Over 2.5", "Home", "Draw", etc.
    odd = Column(DECIMAL(10, 2), nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('match_id', 'bet_type_id', 'bookmaker_id', 'bet_value'),
    )

    match = relationship('Match', back_populates='bets')
    bet_type = relationship('BetType', back_populates='bets')
    bookmaker = relationship('Bookmaker', back_populates='bets')
     
class Country(Base):
    __tablename__ = 'countries'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    code = Column(String(100))

    leagues = relationship('League', back_populates='country')

class Season(Base):
    __tablename__ = 'seasons'

    id = Column(Integer, primary_key=True)
    year = Column(String(9), nullable=False)
    league_id = Column(Integer, ForeignKey('leagues.id'))
    type = Column(String(50), nullable=False)
    logo = Column(String(50), nullable=False)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    current = Column(Boolean, default=False)  # Indica se a temporada é a atual
    league = relationship('League')

class Prediction(Base):
    __tablename__ = 'predictions'

    match_id = Column(Integer, ForeignKey('matches.id'), nullable=False)
    bet_type_id = Column(Integer, ForeignKey('bet_types.id'), nullable=False)  
    valor = Column(String(10), nullable=False)  # Ex: >2.5, <1.5
    probabilidade = Column(DECIMAL(5, 2))  # Ex: 0.60 para 60%
    confianca = Column(DECIMAL(5, 2))  # Ex: 0.85 para 85%
    status = Column(String(5))  # 'green', 'red'
    date = Column(DateTime, nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('match_id', 'bet_type_id', 'valor'),
    )

    match = relationship("Match", back_populates="predictions")
    bet_type = relationship("BetType", back_populates="predictions")
    
class ModelPredictions(Base):
    __tablename__ = 'model_predictions'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)  # Nome do modelo
    tipo = Column(String(50), nullable=False)  # Tipo do Modelo (Ex: "Regressão", "Classificação")
    target = Column(String(50), nullable=False)  # Alvo do modelo (Ex: "Gols", "Resultado")
    features = Column(JSON, nullable=False)  # Características usadas no modelo (Ex: "Gols, Assistências")
    path = Column(String(255), nullable=False)
    is_production = Column(Boolean, default=False)  # Indica se o modelo está em produção
    created_at = Column(DateTime, nullable=False)  # Data de criação do modelo  

    __table_args__ = (
        PrimaryKeyConstraint('id'),
    )
    
    # Relacionamento com as previsões
    predictions_reviews = relationship('ModelPredictionReviews', back_populates='model_prediction')

class ModelPredictionReviews(Base):
    __tablename__ = 'model_prediction_reviews'

    id = Column(Integer, primary_key=True)
    model_prediction_id = Column(Integer, ForeignKey('model_predictions.id'), nullable=False)  # ID do modelo de previsão
    type = Column(String(50), nullable=False)  # Tipo de review f1, accuracy, etc.
    value = Column(DECIMAL(5, 2), nullable=False)  # Valor da métrica de avaliação (Ex: 0.85 para 85% de precisão)
    date = Column(DateTime, nullable=False)  # Data da avaliação
    comments = Column(String(255))  # Descrição da avaliação (opcional)
    test_range = Column(String(100))  # Intervalo de teste (Ex: "2023-01-01 a 2023-12-31")
    __table_args__ = (
        PrimaryKeyConstraint('id'),
    )
    model_prediction = relationship('ModelPredictions', back_populates='predictions_reviews')

class BetCombination(Base):
    __tablename__ = 'bet_combinations'
    
    combination_id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=datetime.now)
    total_odds = Column(DECIMAL(5,2), nullable=False)
    avg_probability = Column(DECIMAL(5,2), nullable=False)
    avg_confidence = Column(DECIMAL(5,2), nullable=False)
    num_bets = Column(Integer, nullable=False)
    min_odds = Column(DECIMAL(5,2), nullable=False)
    max_odds = Column(DECIMAL(5,2), nullable=False)
    result = Column(Boolean, nullable=True)
    payout = Column(DECIMAL(5,2), nullable=True)
    
    # Relacionamento com as apostas individuais
    bets = relationship("CombinationBet", back_populates="combination")

class CombinationBet(Base):
    __tablename__ = 'combination_bets'
    
    bet_id = Column(Integer, primary_key=True)
    combination_id = Column(Integer, ForeignKey('bet_combinations.combination_id'))
    match_id = Column(Integer, ForeignKey('matches.id'))
    match_name = Column(String(100), nullable=False)
    bet_type = Column(String(100), nullable=False)
    odd = Column(DECIMAL(5,2), nullable=False)
    probability = Column(DECIMAL(5,2), nullable=False)
    confidence = Column(DECIMAL(5,2), nullable=False)
    result = Column(Boolean, nullable=True)
    bet_status = Column(String(20), default='pending')
    
    # Relacionamento
    combination = relationship("BetCombination", back_populates="bets")  
    matches = relationship("Match", back_populates="combination_bets")


#Criando a sessão
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Função para criar as tabelas no banco de dados
def create_tables():
    Base.metadata.create_all(bind=engine)

# Função para obter a sessão do banco de dados
def get_db():
    db = SessionLocal()
    try:
        return db
    finally:
        db.close()