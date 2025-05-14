from pyspark.sql import SparkSession, DataFrame, Window
from pyspark.sql import functions as F
from dotenv import load_dotenv
from pathlib import Path
import psycopg2
import os

load_dotenv()

class FootballStatsProcessor:
    DEBUG = True  # No início da classe
    
    def __init__(self):
        self.spark = self._initialize_spark()
        self.db_url = os.getenv("DATABASE_URL_SPARK")

    def _initialize_spark(self):
        """Configura e inicializa a sessão Spark"""
        return SparkSession.builder \
            .appName("FootballStatistics") \
            .config("spark.driver.memory", "4g") \
            .config("spark.sql.shuffle.partitions", "8") \
            .config("spark.ui.port", "4041") \
            .config("spark.jars", str(Path(__file__).parent / "postgresql-42.2.27.jar")) \
            .getOrCreate()

    def read_table(self, table_name: str) -> DataFrame:
        """Lê uma tabela do banco de dados"""
        db_props = {
            "user": os.getenv("DB_USER"),
            "password": os.getenv("DB_PASS"),
            "driver": "org.postgresql.Driver"
        }
        return self.spark.read.jdbc(self.db_url, table_name, properties=db_props)

    def process_season(self, league_id: int, start_date: str, end_date: str, season_year: str) -> DataFrame:
        """Processa uma temporada completa"""
        matches = self._load_season_matches(league_id, start_date, end_date, season_year)
        if(matches.count()) == 0:
            return 0
        team_ids = self._get_unique_team_ids(matches)
        team_stats = self._calculate_season_stats(matches, team_ids)
        return self._prepare_match_stats(matches, team_stats)

    def _load_season_matches(self, league_id: int, start_date: str, end_date: str, season_year: str) -> DataFrame:
        """Carrega e filtra as partidas da temporada"""
        return self.read_table("matches") \
            .filter(
                (F.col("status") == '1') & 
                (F.col("league_id") == league_id) & 
                #(F.col("home_team_points").isNull()) & 
                (F.col("data") >= start_date) & 
                (F.col("data") <= end_date)
            ) \
            .withColumn("season", F.lit(season_year)) \
            .withColumn("matchday", F.dense_rank().over(Window.orderBy("data"))) \
            .orderBy("data")

    def _get_unique_team_ids(self, matches_df: DataFrame) -> list:
        """Obtém todos os IDs únicos de times que participaram da temporada"""
        home_teams = matches_df.select("home_team_id").distinct()
        away_teams = matches_df.select("away_team_id").distinct()
        return home_teams.union(away_teams).distinct().rdd.flatMap(lambda x: x).collect()

    def _calculate_season_stats(self, matches_df: DataFrame, team_ids: list) -> DataFrame:
        """Calcula estatísticas acumuladas para cada time"""
        # Extrair performances de todos os times
        performances = self._extract_all_performances(matches_df)
        
        # Criar estrutura completa de times x rodadas
        calendar = self._create_full_calendar(matches_df, team_ids)
        
        # Juntar com performances reais
        stats = calendar.join(performances, ["team_id", "matchday"], "left").fillna(0)
        
        # Calcular estatísticas acumuladas até a rodada anterior
        return self._calculate_cumulative_stats(stats)

    def _extract_all_performances(self, matches_df: DataFrame) -> DataFrame:
        """Extrai o desempenho de todos os times em todas as partidas"""
        home_stats = self._extract_team_performance(matches_df, "home")
        away_stats = self._extract_team_performance(matches_df, "away")
        return home_stats.unionByName(away_stats)

    def _extract_team_performance(self, df: DataFrame, side: str) -> DataFrame:
        """Extrai estatísticas de um time (casa ou visitante) por partida"""
        is_home = side == "home"
        prefix = f"{side}_team_"
        opponent_prefix = "away_team_" if is_home else "home_team_"
        
        return df.select(
            F.col(f"{prefix}id").alias("team_id"),
            "matchday",
            F.col(f"{prefix}goals").alias("goals_for"),
            F.col(f"{opponent_prefix}goals").alias("goals_against"),
            F.col(f"{prefix}yellow_cards").alias("yellow_cards"),
            F.col(f"{prefix}red_cards").alias("red_cards"),
            F.when(
                F.col(f"{prefix}goals") > F.col(f"{opponent_prefix}goals"), 3
            ).when(
                F.col(f"{prefix}goals") == F.col(f"{opponent_prefix}goals"), 1
            ).otherwise(0).alias("points")
        )

    def _create_full_calendar(self, matches_df: DataFrame, team_ids: list) -> DataFrame:
        """Cria um calendário completo de times x rodadas"""
        matchdays = matches_df.select("matchday").distinct()
        teams = self.spark.createDataFrame([(tid,) for tid in team_ids], ["team_id"])
        return matchdays.crossJoin(teams)

    def _calculate_cumulative_stats(self, stats_df: DataFrame) -> DataFrame:
        """Calcula estatísticas acumuladas até a rodada anterior"""
        window = Window.partitionBy("team_id").orderBy("matchday").rowsBetween(Window.unboundedPreceding, -1)
        
        return stats_df \
            .withColumn("total_points", F.sum("points").over(window)) \
            .withColumn("total_goals_for", F.sum("goals_for").over(window)) \
            .withColumn("total_goals_against", F.sum("goals_against").over(window)) \
            .withColumn("total_yellow_cards", F.sum("yellow_cards").over(window)) \
            .withColumn("total_red_cards", F.sum("red_cards").over(window)) \
            .fillna(0, subset=["total_points", "total_goals_for", "total_goals_against", 
                             "total_yellow_cards", "total_red_cards"]) \
            .withColumn("goal_diff", F.col("total_goals_for") - F.col("total_goals_against")) \
            .withColumn("rank", F.rank().over(Window.partitionBy("matchday").orderBy(
                F.desc("total_points"),
                F.desc("goal_diff"),
                F.desc("total_goals_for"),
                F.asc("total_yellow_cards"),
                F.asc("total_red_cards")
            )))

    def _prepare_match_stats(self, matches_df: DataFrame, stats_df: DataFrame) -> DataFrame:
        """Prepara as estatísticas para atualização no banco de dados"""
        stats_for_join = stats_df.select(
            "team_id", "matchday",
            "rank", "total_points", "total_goals_for",
            "total_goals_against", "goal_diff",
            "total_yellow_cards", "total_red_cards"
        )

        home_stats = matches_df.join(
            stats_for_join,
            (matches_df["home_team_id"] == stats_for_join["team_id"]) & 
            (matches_df["matchday"] == stats_for_join["matchday"]),
            "left"
        ).select(
            matches_df["id"].alias("match_id"),
            F.col("rank").alias("home_team_rank"),
            F.col("total_points").alias("home_team_points"),
            F.col("total_goals_for").alias("home_team_goals_pro"),
            F.col("total_goals_against").alias("home_team_goals_against"),
            F.col("goal_diff").alias("home_team_goal_diff"),
            F.col("total_yellow_cards").alias("home_team_yellow_cards_total"),
            F.col("total_red_cards").alias("home_team_red_cards_total")
        )

        away_stats = matches_df.join(
            stats_for_join,
            (matches_df["away_team_id"] == stats_for_join["team_id"]) & 
            (matches_df["matchday"] == stats_for_join["matchday"]),
            "left"
        ).select(
            matches_df["id"].alias("match_id"),
            F.col("rank").alias("away_team_rank"),
            F.col("total_points").alias("away_team_points"),
            F.col("total_goals_for").alias("away_team_goals_pro"),
            F.col("total_goals_against").alias("away_team_goals_against"),
            F.col("goal_diff").alias("away_team_goal_diff"),
            F.col("total_yellow_cards").alias("away_team_yellow_cards_total"),
            F.col("total_red_cards").alias("away_team_red_cards_total")
        )

        return home_stats.join(away_stats, "match_id", "inner")

    def update_database(self, stats_df: DataFrame):
        """Atualiza o banco de dados com as novas estatísticas"""
        conn = None
        try:
            conn = psycopg2.connect(
                dbname=os.getenv("DB_BASE"),
                user=os.getenv("DB_USER"),
                password=os.getenv("DB_PASS"),
                host=os.getenv("DB_HOST"),
                port=os.getenv("DB_PORT")
            )
            cursor = conn.cursor()

            update_query = """
                UPDATE matches SET
                    home_team_rank = %s,
                    away_team_rank = %s,
                    home_team_points = %s,
                    away_team_points = %s,
                    home_team_goals_pro = %s,
                    away_team_goals_pro = %s,
                    home_team_goals_against = %s,
                    away_team_goals_against = %s,
                    home_team_goal_diff = %s,
                    away_team_goal_diff = %s,
                    home_team_yellow_cards_total = %s,
                    away_team_yellow_cards_total = %s,
                    home_team_red_cards_total = %s,
                    away_team_red_cards_total = %s
                WHERE id = %s
            """

            # Processar em lotes para melhor performance
            batch_size = 1000
            rows = stats_df.collect()
            
            for i in range(0, len(rows), batch_size):
                batch = rows[i:i + batch_size]
                params = [(
                    row['home_team_rank'], row['away_team_rank'],
                    row['home_team_points'], row['away_team_points'],
                    row['home_team_goals_pro'], row['away_team_goals_pro'],
                    row['home_team_goals_against'], row['away_team_goals_against'],
                    row['home_team_goal_diff'], row['away_team_goal_diff'],
                    row['home_team_yellow_cards_total'], row['away_team_yellow_cards_total'],
                    row['home_team_red_cards_total'], row['away_team_red_cards_total'],
                    row['match_id']
                ) for row in batch]
                
                cursor.executemany(update_query, params)
                conn.commit()

        except Exception as e:
            print(f"Error updating database: {str(e)}")
            if conn:
                conn.rollback()
            raise
        finally:
            if conn:
                conn.close()
    
    def _get_season(self,league_id:int):
        seasons_df = self.read_table("seasons").filter(
            (F.col("current") == True) &
            (F.col("league_id") == league_id)
        ).first()
        return seasons_df
           
    def update_next_round(self, league_id: int):
        """
        Atualiza TODAS as partidas da PRÓXIMA RODADA (status = 0)
        com estatísticas acumuladas ATÉ A PRÓPRIA RODADA (incluindo ela mesma).
        """
        try:
            print("Iniciando processamento da próxima rodada...")
            
            # 1. Obter a temporada atual
            season = self._get_season(league_id)
            if not season:
                print("Nenhuma temporada ativa encontrada para esta liga!")
                return

            # 2. Obter TODAS partidas da temporada (ordenadas por data)
            all_matches = self.read_table("matches") \
                .filter(
                    (F.col("league_id") == league_id) &
                    (F.col("data") >= season['start_date']) &
                    (F.col("data") <= season['end_date'])
                ) \
                .cache()

            # 3. Identificar a próxima rodada não jogada (status = 0)
            next_round_matches = all_matches.filter(F.col("status") == "0")
            
            if next_round_matches.count() == 0:
                print("Nenhuma partida pendente encontrada!")
                all_matches.unpersist()
                return

            # 4. Determinar o número da próxima rodada
            next_round = next_round_matches.orderBy("data").first()["matchday"]
            

            # 5. Obter partidas para cálculo (todas até a próxima rodada INCLUSIVE)
            matches_for_stats = all_matches.filter(
                (F.col("matchday") <= next_round)
            ).cache()

            # 6. Verificação crítica de dados
            if matches_for_stats.count() == 0:
                print("Aviso: Nenhuma partida encontrada para cálculo.")
                return

            # 7. Calcular estatísticas (incluindo a própria próxima rodada)
            team_ids = self._get_unique_team_ids(matches_for_stats)
            team_stats = self._calculate_season_stats(matches_for_stats, team_ids)
            
            # 8. Preparar dados APENAS para as partidas da próxima rodada
            round_stats = self._prepare_match_stats(
                next_round_matches.filter(F.col("matchday") == next_round),
                team_stats
            )
            
           
            # 10. Atualizar banco de dados
            self.update_database(round_stats)
            
        except Exception as e:
            print(f"Erro ao processar rodada: {str(e)}")
            raise
        finally:
            all_matches.unpersist() if 'all_matches' in locals() else None
            matches_for_stats.unpersist() if 'matches_for_stats' in locals() else None

    def process_and_update_all_seasons(self):
        """Processa e atualiza todas as temporadas"""
        try:
            seasons_df = self.read_table("seasons").filter(
                (F.col("year") >= '2024')
            )

            for row in seasons_df.collect():
                print(f"Processing season {row['year']}...")
                updated_stats = self.process_season(
                    row['league_id'], 
                    row['start_date'], 
                    row['end_date'],
                    row['year']
                )
                if updated_stats == 0:
                    print(f"Não há jogos para a liga {row['league_id']} na season {row['year']}")
                    continue
                self.update_database(updated_stats)
                print(f"Season {row['year']} processed successfully.")
                
        except Exception as e:
            print(f"Error processing seasons: {str(e)}")
            raise

if __name__ == "__main__":
    try:
        print("Starting statistics processing...")
        processor = FootballStatsProcessor()
        processor.process_and_update_all_seasons()
        #processor.update_next_round(39)
        print("Processing completed successfully.")
    except Exception as e:
        print(f"Failed to process statistics: {str(e)}")
        exit(1)