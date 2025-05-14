from pyspark.sql import functions as F
from pyspark.sql.window import Window
from typing import List, Dict
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.spark_manager import SparkManager
from pyspark.sql.dataframe import DataFrame
from functools import lru_cache

class FootballClassification(SparkManager):
    
    def __init__(self, app_name="FootballAnalytics"):
        super().__init__(app_name)
        
    def get_league_classification(self, league_id: int, season_id: int):
        '''
            Retornar os dados de classificação da liga
        '''
        
        query = f'''
        (WITH partidas_home AS (
            SELECT
                m.home_team_id AS team_id,
                t.name AS team_name,
                m.home_team_goals AS gols_pro,
                m.away_team_goals AS gols_contra,
                CASE
                    WHEN m.home_team_goals > m.away_team_goals THEN 3
                    WHEN m.home_team_goals = m.away_team_goals THEN 1
                    ELSE 0
                END AS pontos,
                CASE
                    WHEN m.home_team_goals > m.away_team_goals THEN 'V'
                    WHEN m.home_team_goals = m.away_team_goals THEN 'E'
                    ELSE 'D'
                END AS resultado
            FROM matches m
            JOIN teams t ON t.id = m.home_team_id
            JOIN seasons s ON s.league_id = m.league_id
            WHERE m.status = '1'
            AND m.league_id = {league_id}
            AND s.id = {season_id}
            AND m.data BETWEEN s.start_date AND s.end_date
        ),
        partidas_away AS (
            SELECT
                m.away_team_id AS team_id,
                t.name AS team_name,
                m.away_team_goals AS gols_pro,
                m.home_team_goals AS gols_contra,
                CASE
                    WHEN m.away_team_goals > m.home_team_goals THEN 3
                    WHEN m.away_team_goals = m.home_team_goals THEN 1
                    ELSE 0
                END AS pontos,
                CASE
                    WHEN m.away_team_goals > m.home_team_goals THEN 'V'
                    WHEN m.away_team_goals = m.home_team_goals THEN 'E'
                    ELSE 'D'
                END AS resultado
            FROM matches m
            JOIN teams t ON t.id = m.away_team_id
            JOIN seasons s ON s.league_id = m.league_id
            WHERE m.status = '1'
            AND m.league_id = {league_id}
            AND s.id = {season_id}
            AND m.data BETWEEN s.start_date AND s.end_date
        ),
        todas_partidas AS (
            SELECT * FROM partidas_home
            UNION ALL
            SELECT * FROM partidas_away
        )
        SELECT
            team_id,
            team_name time,
            COUNT(*) AS jogos,
            SUM(CASE WHEN resultado = 'V' THEN 1 ELSE 0 END) AS vitorias,
            SUM(CASE WHEN resultado = 'E' THEN 1 ELSE 0 END) AS empates,
            SUM(CASE WHEN resultado = 'D' THEN 1 ELSE 0 END) AS derrotas,
            SUM(gols_pro) AS gols_pro,
            SUM(gols_contra) AS gols_contra,
            SUM(gols_pro - gols_contra) AS saldo,
            SUM(pontos) AS pontos
        FROM todas_partidas
        GROUP BY team_id, team_name
        ORDER BY pontos DESC, saldo DESC, gols_pro DESC) as classification

        '''
        df = self.read_from_db(query)

        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    def get_rounds(self, league_id: int, season_id: int):
        '''
            Retornar as rodadas da liga
        '''
        query = f"""
            (SELECT 
            m.id AS match_id,
            m.data AS match_date,
            m.matchday,
            l.name AS league_name,
            s.year AS season_year,
            ht.name AS home_team,
            at.name AS away_team,
            m.home_team_goals,
            m.away_team_goals,
            m.status
        FROM matches m
        JOIN teams ht ON m.home_team_id = ht.id
        JOIN teams at ON m.away_team_id = at.id
        JOIN leagues l ON m.league_id = l.id
        JOIN seasons s ON s.league_id = l.id
        WHERE m.league_id = {league_id}
        AND s.id = {season_id}
        AND m.data BETWEEN s.start_date AND s.end_date
        ORDER BY m.data DESC ) as rounds_league
        """
        
        df = self.read_from_db(query)
        
        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    
    
    
    