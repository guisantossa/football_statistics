from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, DateTime, DECIMAL, Boolean
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

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
    home_team_id = Column(Integer, ForeignKey('teams.id'))
    away_team_id = Column(Integer, ForeignKey('teams.id'))
    home_team_goals = Column(Integer)
    away_team_goals = Column(Integer)
    home_team_possession = Column(DECIMAL(5, 2))
    away_team_possession = Column(DECIMAL(5, 2))
    home_team_shots = Column(Integer)
    away_team_shots = Column(Integer)
    home_team_shots_on_target = Column(Integer)
    away_team_shots_on_target = Column(Integer)
    home_team_fouls = Column(Integer)
    away_team_fouls = Column(Integer)
    home_team_corners = Column(Integer)
    away_team_corners = Column(Integer)
    home_team_yellow_cards = Column(Integer)
    away_team_yellow_cards = Column(Integer)
    home_team_red_cards = Column(Integer)
    away_team_red_cards = Column(Integer)
    league_id = Column(Integer, ForeignKey('leagues.id'))
    status = Column(String(1), nullable=False)
    matchday = Column(Integer, nullable=False)

    home_team = relationship('Team', foreign_keys=[home_team_id], back_populates='matches_home')
    away_team = relationship('Team', foreign_keys=[away_team_id], back_populates='matches_away')
    league = relationship('League', back_populates='matches')
    statistics = relationship('PlayerStatistic', back_populates='match')

class League(Base):
    __tablename__ = 'leagues'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    type = Column(String(50), nullable=False)
    logo = Column(String(255))
    country_id = Column(Integer, ForeignKey('countries.id'))

    country = relationship('Country', back_populates='leagues')
    matches = relationship('Match', back_populates='league')

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
    current = Column(Boolean, default=False)  # Indica se a temporada é a atual
    league = relationship('League')

class SeasonTeam(Base):
    __tablename__ = 'season_teams'

    season_id = Column(Integer, ForeignKey('seasons.id'), primary_key=True)
    team_id = Column(Integer, ForeignKey('teams.id'), primary_key=True)

    season = relationship('Season')
    team = relationship('Team')


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