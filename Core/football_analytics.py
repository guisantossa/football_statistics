from pyspark.sql import functions as F
from pyspark.sql.window import Window
from typing import List, Dict
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.spark_manager import SparkManager
from pyspark.sql.dataframe import DataFrame
from functools import lru_cache

class FootballAnalytics(SparkManager):
    def __init__(self, app_name="FootballAnalytics"):
        super().__init__(app_name)
    
    @lru_cache(maxsize=128)
    def get_match_statistics(self, match_id):
        '''
        Retorna as estatisticas da partida em questão
        '''
        query = f'''
            (Select
                home_team_goals,
                away_team_goals,
                home_team_possession,
                away_team_possession,
                home_team_shots,
                away_team_shots,
                home_team_shots_on_target,
                away_team_shots_on_target,
                home_team_fouls,
                away_team_fouls,
                home_team_corners,
                away_team_corners,
                home_team_yellow_cards,
                away_team_yellow_cards,
                home_team_red_cards,
                away_team_red_cards,
                home_team_goals_firsthalf,
                away_team_goals_firsthalf
            FROM
                matches where id = {match_id}) as match_id
            
        '''
        df = self.read_from_db(query)
        

        if df.count() == 0:
            return {}

        row = df.first().asDict()

        home_stats = {
            'avg_goals': row['home_team_goals'],
            'avg_possession': row['home_team_possession'],
            'avg_shots': row['home_team_shots'],
            'avg_shots_on_target': row['home_team_shots_on_target'],
            'avg_fouls': row['home_team_fouls'],
            'avg_corners': row['home_team_corners'],
            'avg_yellow_cards': row['home_team_yellow_cards'],
            'avg_red_cards': row['home_team_red_cards'],
            "avg_firsthalf_goals": row["home_team_goals_firsthalf"]
        }

        away_stats = {
            'avg_goals': row['away_team_goals'],
            'avg_possession': row['away_team_possession'],
            'avg_shots': row['away_team_shots'],
            'avg_shots_on_target': row['away_team_shots_on_target'],
            'avg_fouls': row['away_team_fouls'],
            'avg_corners': row['away_team_corners'],
            'avg_yellow_cards': row['away_team_yellow_cards'],
            'avg_red_cards': row['away_team_red_cards'],
            "avg_firsthalf_goals": row["away_team_goals_firsthalf"]
        }

        return home_stats, away_stats
    
    def get_teams_stats_by_league(self, league_id: int):
        """Pega estatísticas de TODOS os times de uma liga específica"""
        query = f"""
        (WITH current_season AS (
            SELECT 
                start_date,
                end_date
            FROM seasons
            WHERE current IS TRUE AND league_id = {league_id}
            LIMIT 1
        ),
        matches_in_season AS (
            SELECT *
            FROM matches
            WHERE league_id = {league_id}
            AND status = '1'
            AND data BETWEEN (SELECT start_date FROM current_season) 
                        AND (SELECT end_date FROM current_season)
        ),
        team_stats AS (
            SELECT 
                t.id,
                t.name,
                t.short_name,
                t.img_url,
                COUNT(*) as total_matches,
                -- Ataque
                AVG(CASE WHEN t.id = m.home_team_id THEN m.home_team_goals ELSE m.away_team_goals END) as avg_goals_scored,
                AVG(CASE WHEN t.id = m.home_team_id THEN m.away_team_goals ELSE m.home_team_goals END) as avg_goals_conceded,
                SUM(CASE WHEN t.id = m.home_team_id THEN m.home_team_goals ELSE m.away_team_goals END) as total_goals_scored,
                -- Posse
                AVG(CASE WHEN t.id = m.home_team_id THEN m.home_team_possession ELSE m.away_team_possession END) as avg_possession,
                -- Finalizações
                AVG(CASE WHEN t.id = m.home_team_id THEN m.home_team_shots ELSE m.away_team_shots END) as avg_shots,
                AVG(CASE WHEN t.id = m.home_team_id THEN m.home_team_shots_on_target ELSE m.away_team_shots_on_target END) as avg_shots_on_target,
                -- Disciplina
                SUM(CASE WHEN t.id = m.home_team_id THEN m.home_team_yellow_cards ELSE m.away_team_yellow_cards END) as total_yellow_cards,
                SUM(CASE WHEN t.id = m.home_team_id THEN m.home_team_red_cards ELSE m.away_team_red_cards END) as total_red_cards,
                -- Eficiência
                COUNT(CASE WHEN (t.id = m.home_team_id AND m.home_team_goals > m.away_team_goals) 
                        OR (t.id = m.away_team_id AND m.away_team_goals > m.home_team_goals) 
                    THEN 1 END) as wins,
                -- Desempenho como mandante
                AVG(CASE WHEN t.id = m.home_team_id THEN m.home_team_goals ELSE NULL END) as avg_home_goals,
                -- Desempenho como visitante
                AVG(CASE WHEN t.id = m.away_team_id THEN m.away_team_goals ELSE NULL END) as avg_away_goals
            FROM teams t
            JOIN matches_in_season m ON (t.id = m.home_team_id OR t.id = m.away_team_id)
            GROUP BY t.id, t.name, t.short_name, t.img_url
        )
        SELECT 
            *,
            (ROUND((wins::numeric / NULLIF(total_matches, 0)) * 100, 1))::float as win_percentage,
            (ROUND((avg_shots_on_target::numeric / NULLIF(avg_shots, 0)) * 100, 1))::float as shot_accuracy
        FROM team_stats
        ORDER BY wins DESC, avg_goals_scored DESC
        ) AS teams_stats_query
        """
        df = self.read_from_db(query)
        
        return [row.asDict() for row in df.collect()]  # Retorna lista de dicionários   
    
    def get_next_match(self, team_id: int):
        """Retorna o próximo jogo do time especificado"""
        query = f"""
        (WITH next_match AS (
            SELECT 
                m.id,
                m.data,
                ht.id as home_id,
                at.id as away_id,
                ht.name as home_team,
                at.name as away_team,
                ht.img_url as home_logo,
                at.img_url as away_logo,
                m.status
            FROM matches m
            JOIN teams ht ON m.home_team_id = ht.id
            JOIN teams at ON m.away_team_id = at.id
            WHERE (m.home_team_id = {team_id} OR m.away_team_id = {team_id})
            AND m.status = '0' 
            ORDER BY m.data ASC
            LIMIT 1
        )
        SELECT * FROM next_match) AS next_match_query
        """
        
        df = self.read_from_db(query)
        
        return df.collect()[0].asDict() if df.count() > 0 else None
        
    def get_latest_matches(self, team_id:int , matches: int) -> dict:
        '''
            retorna as ultimas n partidas de um time
        '''
        
        query = f'''
        (
        SELECT
            m.id,
            m.data,
            CASE 
                WHEN m.home_team_id = {team_id} THEN t2.name
                ELSE t1.name
            END AS away_team,
            m.home_team_goals,
            m.away_team_goals,
            CASE 
                WHEN m.home_team_id = {team_id} THEN 'home'
                ELSE 'away'
            END AS location
        FROM matches m
        JOIN teams t1 ON t1.id = m.home_team_id
        JOIN teams t2 ON t2.id = m.away_team_id
        WHERE (m.home_team_id = {team_id} OR m.away_team_id = {team_id})
        AND status = '1'
        ORDER BY m.data DESC
        LIMIT {matches}
        ) AS last_matches
        '''
        
        df = self.read_from_db(query)

        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    
    
    
    