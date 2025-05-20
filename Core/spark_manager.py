from pyspark.sql import SparkSession
from pyspark.sql.dataframe import DataFrame 
from pyspark.sql.functions import col, avg, first
import pandas as pd
import os
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.regression import RandomForestRegressor
from pyspark.ml.evaluation import RegressionEvaluator
from pathlib import Path
from dotenv import load_dotenv
from pyspark.sql.functions import expr
from datetime import datetime
from pyspark.sql import functions as F




class SparkManager:
    def __init__(self, app_name="FootballAnalytics"):
        load_dotenv()
        
        
        self.spark = self._configure_spark(app_name)
        # Configurações do banco RDS
        self.db_url = os.getenv("DATABASE_URL_SPARK")
        
        self.db_properties = {
            "user": os.getenv("DB_USER"),
            "password": os.getenv("DB_PASS"),
            "driver": "org.postgresql.Driver"
        }
    
    def _configure_spark(self, app_name: str) -> SparkSession:
        """Configurações otimizadas para diferentes ambientes"""
        builder = SparkSession.builder.appName(app_name)
        driver_path = str(Path(__file__).parent / "postgresql-42.2.27.jar")
        assert os.path.exists(driver_path), f"Driver JDBC não encontrado em {driver_path}"
        #if os.getenv("ENV") == "local":
        builder.config("spark.driver.memory", "4g") \
                .config("spark.sql.shuffle.partitions", "8") \
                .config("spark.sql.execution.arrow.pandas.enabled", "true") \
                .config("spark.sql.execution.pandas.convertToArrowArraySafely", "true") \
                .config("spark.sql.adaptive.enabled", "true") \
                .config("spark.sql.adaptive.advisoryPartitionSizeInBytes", "64MB") \
                .config("spark.jars", driver_path)
        try:
            return builder.getOrCreate()
        except Exception as e:
            print(f"Falha ao iniciar Spark: {str(e)}")
            raise
        
    
    def read_from_db(self, table_name: str) -> DataFrame:
        """Carrega dados do PostgreSQL para um DataFrame Spark"""
        return self.spark.read \
            .jdbc(url=self.db_url, 
                  table=table_name, 
                  properties=self.db_properties)
    
    def load_leagues(self):
        """Carrega ligas com países associados."""
        
        query = '''
            (
                WITH league_ready as (
                    select league_id from matches group by league_id having count(*) > 1
                )
                SELECT 
                l.id, 
                l.name as league_name,
                c.name as country_name 
            FROM
                leagues l JOIN countries c ON l.country_id = c.id
                          JOIN league_ready lr ON lr.league_id = l.id
                ) as leagues_query
        '''
        return self.read_from_db(query)

    def load_teams(self, league_id: int):
        """Carrega times ÚNICOS de uma liga, filtrados pela season atual e suas partidas."""
        query = f"""
        (WITH 
        -- 1. Pega a season atual da liga
        current_season AS (
            SELECT id ,year, start_date, end_date 
            FROM seasons 
            WHERE league_id = {league_id} AND current = TRUE
            LIMIT 1
        ),
        
        -- 2. Filtra partidas dessa season (assumindo que matches.league_id já vincula à season)
        season_matches AS (
            SELECT m.id, m.home_team_id
            FROM matches m 
            CROSS JOIN current_season cs
            WHERE m.league_id = {league_id}
            AND m.data BETWEEN cs.start_date AND cs.end_date
        )
        
        -- 3. Agrupa times distintos (mandantes + visitantes)
        SELECT DISTINCT t.id, t.name, t.short_name, t.img_url
        FROM teams t
        WHERE t.id IN (
            SELECT home_team_id FROM season_matches
        )) AS teams_query
        """
        
        return self.read_from_db(query)
        
    def stop(self) -> None:
        """Encerra a sessão Spark corretamente"""
        self.spark.stop() 
    
    def load_seasons_by_league(self, league_id):
        '''
            Retorna as Temporadas da Liga selecionada
        '''
        query = f'''
            (SELECT id, concat(year, '/', CAST(CAST(year as int)+1 as varchar) ) as year from seasons where league_id = {league_id}
            ) as seasons_league
            '''
            
        return self.spark.read.jdbc(
            url=self.db_url,
            table=query,
            properties=self.db_properties
        )
        
    def get_matches_per_date(self, data):
        '''Retorna todos os jogos do dia'''
        df = self.spark.read.jdbc(
            url=self.db_url,
            table=f"(Select * from matches where DATE(data) = '{data}') as matches_of_date",
            properties=self.db_properties
        )
        
        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    def get_matches_per_date_complete(self, data):
        '''Retorna todos os jogos do dia'''
        
        filter = f"date(m.data) = '{data}'" if data != datetime.today() else f"m.data BETWEEN (NOW() - INTERVAL '90 minutes') AND (NOW() + INTERVAL '90 minutes')"
        
        query = f"""
               ( SELECT 
                m.id AS match_id,
                m.league_id league_id,
                m.data - INTERVAL '3 HOURS' AS match_date,
                m.matchday,
                m.home_team_id,
                m.away_team_id,
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
            JOIN seasons s ON m.league_id = s.league_id
            WHERE date(m.data) = '{data}'
            and s."current" is true
            ORDER BY 
                data ASC  ) as today_matches
        """
        
        df = self.read_from_db(query)
        
        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    def get_todays_matches(self, league_id: int):
        '''
            Retornar a proxima rodada da liga
        '''
        league_filter = f"AND m.league_id = {league_id}" if league_id else ""
        query = f"""
               ( with next_round as (Select MIN(matchday) next_round from matches m where status= '0' {league_filter} )
                SELECT 
                m.id AS match_id,
                m.league_id league_id,
                m.data AS match_date,
                m.matchday,
                m.home_team_id,
                m.away_team_id,
                l.name AS league_name,
                s.year AS season_year,
                ht.name AS home_team,
                at.name AS away_team,
                m.home_team_goals,
                m.away_team_goals,
                m.status
            FROM matches m
            JOIN next_round nr ON nr.next_round = m.matchday
            JOIN teams ht ON m.home_team_id = ht.id
            JOIN teams at ON m.away_team_id = at.id
            JOIN leagues l ON m.league_id = l.id
            JOIN seasons s ON m.league_id = s.league_id
            WHERE 
            m.status = '0'
            {league_filter}
            AND s.current is true
            ORDER BY 
                data ASC  ) as today_matches
        """
        
        df = self.spark.read.jdbc(
            url=self.db_url,
            table=query,
            properties=self.db_properties
        )
        
        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
       
    def get_team_statistics(self, team_id: int, location: int, limit: int) -> dict:
        """
        Retorna estatísticas médias dos últimos jogos do time.
        """
        
        if(limit is not None):
            limit_sql = f"LIMIT {limit}"
        else:
            limit_sql = ""
            
        if location == 'away':
            location_sql = f"(away_team_id = {team_id})"
        elif location == 'home':
            location_sql = f"(home_team_id = {team_id})"
        else:
            location_sql = f"(home_team_id = {team_id} or away_team_id = {team_id})"
            
            
        
        query = f"""
        (with teams_statistics as (
            select
                {team_id} team_id,
                CASE WHEN home_team_id = {team_id} then home_team_goals else away_team_goals END as goals,
                CASE WHEN home_team_id = {team_id} then home_team_possession else away_team_possession END as possession,
                CASE WHEN home_team_id = {team_id} then home_team_shots else away_team_shots END as shots,
                CASE WHEN home_team_id = {team_id} then home_team_shots_on_target else away_team_shots_on_target END as shots_on_target,
                CASE WHEN home_team_id = {team_id} then home_team_fouls else away_team_fouls END as fouls,
                CASE WHEN home_team_id = {team_id} then home_team_corners else away_team_corners END as corners,
                CASE WHEN home_team_id = {team_id} then home_team_yellow_cards else away_team_yellow_cards END as yellow_cards,
                CASE WHEN home_team_id = {team_id} then home_team_red_cards else away_team_red_cards END as red_cards,
                CASE WHEN home_team_id = {team_id} then home_team_goals_firsthalf else away_team_goals_firsthalf END as firsthalf_goals
            from
                matches m
            where
                {location_sql}
                and status = '1'
            order by	
                data desc 
            {limit_sql}
            )
            select 
                AVG(COALESCE(goals, 0)) AS avg_goals,
                AVG(COALESCE(possession, 0)) AS avg_possession,
                AVG(COALESCE(shots, 0)) AS avg_shots,
                AVG(COALESCE(shots_on_target, 0)) AS avg_shots_on_target,
                AVG(COALESCE(fouls, 0)) AS avg_fouls,
                AVG(COALESCE(corners, 0)) AS avg_corners,
                AVG(COALESCE(yellow_cards, 0)) AS avg_yellow_cards,
                AVG(COALESCE(red_cards, 0)) AS avg_red_cards,
                AVG(COALESCE(firsthalf_goals, 0)) AS avg_firsthalf_goals
            from
                teams_statistics ) as teams
        """
        
        df = self.spark.read.jdbc(
            url=self.db_url,
            table=query,
            properties=self.db_properties
        )

        if df.count() == 0:
            return {}

        row = df.first().asDict()
        # Arredondamento e formatação simples
        return {k: round(v, 1) if isinstance(v, float) else v for k, v in row.items()}
            
    def load_leagues_data(self):
        """Carrega dados básicos das ligas (com países associados)"""
        query = """
        (SELECT l.id, l.name as league_name, l.type, l.logo, 
                c.name as country_name, c.code as country_code
         FROM leagues l
         JOIN countries c ON l.country_id = c.id) as leagues_query
        """
        
        return self.spark.read.jdbc(
            url=self.db_url,
            table=query,
            properties=self.db_properties
        )

    def load_teams_data(self, league_id=None):
        """Carrega dados de times, com filtro opcional por liga"""
        base_query = """
        (SELECT t.id, t.name, t.short_name, t.city, t.img_url,
                l.name as league_name
         FROM teams t
         JOIN season_teams st ON t.id = st.team_id
         JOIN seasons s ON st.season_id = s.id
         JOIN leagues l ON s.league_id = l.id
        """
        
        if league_id:
            query = f"{base_query} WHERE l.id = {league_id}) as teams_query"
        else:
            query = f"{base_query}) as teams_query"
            
        return self.spark.read.jdbc(
            url=self.db_url,
            table=query,
            properties=self.db_properties
        )
    
    def stop(self):
        """Encerra a sessão do Spark"""
        self.spark.stop()
    
    
    
    def load_stat_mapping(self, file_path="Core/stat_mapping.yml"):
        import yaml
        AGG_FUNC_MAP = {
            "avg": avg,
            "sum": sum,
            "max": max,
            "min": min
        }
        with open(file_path, 'r') as file:
            self.stat_mapping =  yaml.safe_load(file)
            
        # Corrigindo o agg_func para ser a função real
        for stat_type, config in self.stat_mapping.items():
            func_name = config.get("agg_func")
            if func_name in AGG_FUNC_MAP:
                config["agg_func"] = AGG_FUNC_MAP[func_name]
    
    def prepare_data_for_model_geral(self, home_id:int, away_id: int, league_id: int, type: str, window_size: int = 10):
        '''
        Junta os dados dos últimos jogos dos dois times, aplica agregações e monta o vetor de features    
        '''
        
        self.stat_info = self.stat_mapping.get(type)
        if not self.stat_info:
            raise ValueError(f"Tipo de estatística '{type}' não reconhecido.")
        
        # Obtém os dados de cada time, agora incluindo as colunas da query
        home_df = self.get_features_for_model(home_id, league_id)
        away_df = self.get_features_for_model(away_id, league_id)
        home_df = home_df.na.fill(0)
        away_df = away_df.na.fill(0)
        last_home = home_df.filter(col("home_team_id") == home_id) \
                    .limit(10) \
                    .orderBy(col("data").desc()) \

        last_away = away_df.filter(col("away_team_id") == away_id) \
                    .limit(10) \
                    .orderBy(col("data").desc()) \

        # HOME TEAM
        home_df = home_df.filter(col("home_team_id") == home_id) \
                    .orderBy(col("data").desc()) \
                    .limit(window_size) \
                    .groupBy() \
                    .agg(*[
                        self.stat_info["agg_func"](col(orig)).alias(f"home_{alias}")
                        for orig, alias in self.stat_info["agg_columns"]
                    ])

        # AWAY TEAM
        away_df = away_df.filter(col("away_team_id") == away_id) \
                    .orderBy(col("data").desc()) \
                    .limit(window_size) \
                    .groupBy() \
                    .agg(*[
                        self.stat_info["agg_func"](col(orig)).alias(f"away_{alias}")
                        for orig, alias in self.stat_info["agg_columns"]
                    ])
        
        # Combine as features dos dois times
        combined_df = home_df.crossJoin(away_df)

        # Cria vetor de features
        feature_cols = [f"home_{alias}" for _, alias in self.stat_info["agg_columns"]] + \
                    [f"away_{alias}" for _, alias in self.stat_info["agg_columns"]]
        
        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        data = assembler.transform(combined_df).select("features")
        # Cálculo da média dos últimos jogos dos times
        
        home_media = home_df.agg(*[
                        self.stat_info["agg_func"](col(f"home_{orig}")).alias(f"home_{alias}")
                        for orig, alias in self.stat_info["agg_columns"]
                    ])

        away_media = away_df.agg(*[
                        self.stat_info["agg_func"](col(f"away_{orig}")).alias(f"away_{alias}")
                        for orig, alias in self.stat_info["agg_columns"]
                    ])
        
        return data, home_media, away_media, last_home, last_away

    def get_features_for_model(self, team_id: int, league_id: int):
        '''
        Executa a query para pegar dados de um time
        '''
        
        query = f'''
        (SELECT home_team_id, away_team_id, data, id as match_id,
            {', '.join(self.stat_info['query_columns'])} 
        FROM 
            matches 
        WHERE 
            league_id = {league_id} 
            AND (home_team_id = {team_id} or away_team_id = {team_id})
            AND status = '1'
        ORDER BY data DESC) as features_league
        '''

        return self.read_from_db(query)
    
    def get_features_for_training(self, league_id: int, windows_size: int = None):
        '''
        Método para pegar as features para treino e uso do ML
        '''
        
        if windows_size:
            windows_size = f"LIMIT {windows_size}"
        else:
            windows_size = ""
            
        query = f'''
        (SELECT home_team_id, away_team_id, data, id as match_id,
            {', '.join(self.stat_info['query_columns'])} 
        FROM 
            matches 
        WHERE 
            league_id = {league_id} 
            AND status = '1'
        ORDER BY data DESC {windows_size}) as features_league
        '''

        return self.read_from_db(query)

    def prepare_training_data(self, league_id: int, stat_type: str):
        """
        Prepara os dados de treinamento para o modelo, com base em jogos anteriores da liga.
        """
        # Verifica se o tipo de estatística é válido
        self.stat_info = self.stat_mapping.get(stat_type)
        if not self.stat_info:
            raise ValueError(f"Tipo de estatística '{stat_type}' não reconhecido.")
        
        # Lê os dados da liga com base no mapeamento
        df = self.get_features_for_training(league_id)
        
         # Define colunas de features e target
        feature_cols = [col_name for col_name in self.stat_info["feature_cols"]]
        label_col = self.stat_info["target"]
        
        # Define a variável alvo
        df = df.withColumn(self.stat_info['target'], expr(self.stat_info['target_expr']))
        # Remover todas as linhas com valores nulos em qualquer coluna
        df = df.dropna()
        
        # Monta vetor de features
        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        df = assembler.transform(df)
        
        # Seleciona apenas features + label
        training_data = df.select("features", col(label_col).alias("label"))

        return training_data
    
    def train_random_forest(self, train_data):
        '''
        Treina o modelo de Random Forest com os dados fornecidos
        '''
        from pyspark.ml.tuning import ParamGridBuilder, TrainValidationSplit
        
        rf = RandomForestRegressor(featuresCol='features', labelCol='label')
        
        # Define a grade de parâmetros
        paramGrid = ParamGridBuilder() \
            .addGrid(rf.numTrees, [20, 50, 100]) \
            .addGrid(rf.maxDepth, [5, 10, 15]) \
            .build()
            
        # Avaliador de regressão com RMSE
        evaluator = RegressionEvaluator(labelCol='label', predictionCol='prediction', metricName='rmse')
        
        # TrainValidationSplit (80% treino / 20% validação)
        tvs = TrainValidationSplit(
            estimator=rf,
            estimatorParamMaps=paramGrid,
            evaluator=evaluator,
            trainRatio=0.8,
            seed=42
        )
        
        # Treina e seleciona o melhor modelo
        model = tvs.fit(train_data)

        # Aplica o melhor modelo nos dados de validação e calcula RMSE
        predictions = model.transform(train_data)
        rmse = evaluator.evaluate(predictions)
        # Coleta informações do melhor modelo
        best_model = model.bestModel
        num_trees = best_model.getNumTrees
        max_depth = best_model.getOrDefault('maxDepth')
        n_amostras = train_data.count()
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Exibe no terminal
        print("\n📊 Treino realizado:")
        print(f" - Estatística: {self.stat_info['target']}")
        print(f" - Amostras: {n_amostras}")
        print(f" - RMSE: {rmse:.4f}")
        print(f" - numTrees: {num_trees}")
        print(f" - maxDepth: {max_depth}")

        # Cria log e salva
        log_data = {
            "timestamp": [timestamp],
            "stat_type": [self.stat_info["target"]],
            "n_amostras": [n_amostras],
            "rmse": [rmse],
            "numTrees": [num_trees],
            "maxDepth": [max_depth]
        }

        log_df = pd.DataFrame(log_data)
        log_path = "treinos_rf.csv"

        # Se o arquivo já existir, faz append sem duplicar o cabeçalho
        if os.path.exists(log_path):
            log_df.to_csv(log_path, mode='a', header=False, index=False)
        else:
            log_df.to_csv(log_path, index=False)

        return best_model, rmse
    
    def call_models(self, league_id:int, home_id:int, away_id:int, models):
        """
        Executa predições para os modelos especificados com base nos dados dos últimos 5 jogos.
        Carrega os modelos de Random Forest treinados por estatística e liga,
        realiza as predições e calcula o nível de confiança com base no desvio da média.

        Parâmetros:
        - league_id (int): ID da liga.
        - home_id (int): ID do time mandante.
        - away_id (int): ID do time visitante.
        - models (list): Lista com os nomes das estatísticas/modelos a serem utilizados.

        Retorna:
        - List[dict]: Resultados contendo predição, médias, dados dos últimos jogos e nível de confiança.
        """
        from pyspark.ml.regression import RandomForestRegressionModel
        
        self.load_stat_mapping()
        
        resultados = []
        for model_name in models:
            self.stat_info = self.stat_mapping.get(model_name)
            
            model_path = f"models/randomForest/rf_{model_name}_{league_id}"
            model = RandomForestRegressionModel.load(model_path)
            
            
            dados, home_media, away_media, last_home, last_away = self.prepare_data_for_model_geral(home_id,away_id,league_id,model_name,5)
            
            
 
            prediction = model.transform(dados)
           
            predicted = prediction.select("prediction").collect()[0][0]
            
            home_team_predict = home_media.select(f"home_home_team_{model_name}").collect()[0][0]
            away_team_predict = away_media.select(f"away_away_team_{model_name}").collect()[0][0]
            
            valuate = self.prediction_valuate(last_home, last_away, predicted, home_team_predict + away_team_predict)
            
            
            
        return valuate, home_team_predict, away_team_predict
         
    def prediction_valuate(self, home, away, predicao, media_ultimas):
        col_for, col_against = self.stat_info['target_expr'].split(' + ')
        
        # HOME
        home = (
            home
            .withColumn("total_real", F.col(col_for) + F.col(col_against))
            .withColumn("direcao_real", F.when(F.col("total_real") > predicao, "over").otherwise("under"))
            .withColumn("direcao_prevista", F.when(F.lit(predicao) < media_ultimas, "under").otherwise("over"))
        )

        # AWAY
        away = (
            away
            .withColumn("total_real", F.col(col_for) + F.col(col_against))
            .withColumn("direcao_real", F.when(F.col("total_real") > predicao, "over").otherwise("under"))
            .withColumn("direcao_prevista", F.when(F.lit(predicao) > media_ultimas, "under").otherwise("over"))
        )

        # HISTÓRICO
        historico = home.unionByName(away)
        # COMPARAÇÃO PREVISTA VS REAL
        historico = historico.withColumn(
            "acerto_direcao",
            F.when(F.col("direcao_real") == F.col("direcao_prevista"), "acerto").otherwise("erro")
        )

        # AGREGA RESULTADOS
        agregados = (
            historico.groupBy("acerto_direcao")
            .count()
            .groupBy()
            .pivot("acerto_direcao", ["acerto", "erro"])
            .agg(F.first("count"))
            .withColumn("total", F.lit(historico.count()))
        )

        # MELHOR APOSTA
        direcao_final = (
            historico.groupBy("direcao_real")
            .count()
            .orderBy(F.col("count").desc())
            .first()
        )

        agregados_dict = agregados.first().asDict() if agregados.count() > 0 else {}
        total = agregados_dict.get("total", 1)

        return {
            "predicao": predicao,
            "historico_total": total,
            "acertos": agregados_dict.get("acerto", 0),
            "erros": agregados_dict.get("erro", 0),
            "confianca_estimativa": round(100 * agregados_dict.get("acerto", 0) / total, 1) if total > 0 else 0.0,
            "melhor_aposta": direcao_final["direcao_real"] if direcao_final else "indefinido"
        }

    #### LETRA MORTA ### Mas util para consultas e entendimentos
    def get_fouls_features(self, team_id: int, window_size: int = 5):
        """Calcula features de faltas para um time específico"""
        query = f"""
        (
        SELECT 
            m.id match_id,
            m.data,
            CASE WHEN m.home_team_id = {team_id} THEN 
                m.home_team_fouls ELSE m.away_team_fouls END AS team_fouls,
            CASE WHEN m.home_team_id = {team_id} THEN 
                m.away_team_fouls ELSE m.home_team_fouls END AS opponent_fouls,
            CASE WHEN m.home_team_id = {team_id} THEN 
                m.home_team_possession ELSE m.away_team_possession END AS team_possession,
            CASE WHEN m.home_team_id = {team_id} THEN 
                m.away_team_possession ELSE m.home_team_possession END AS opponent_possession,
            CASE WHEN m.home_team_id = {team_id} THEN 
                1 ELSE 0 END AS location
        FROM matches m
        WHERE (m.home_team_id = {team_id} OR m.away_team_id = {team_id})
        AND m.status = '1'
        ORDER BY m.data DESC
        LIMIT {window_size}
        ) as raw_fouls_data
        """
        return self.read_from_db(query)   
    def get_fouls_features_league(self, league_id: int, window_size: int = 1000):
        """Calcula features de faltas para todos os times de uma liga"""
        query = f"""
        (
            SELECT 
                m.id AS match_id,
                m.data,
                t.id AS team_id,
                
                -- Faltas
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_fouls ELSE m.away_team_fouls END AS team_fouls,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_fouls ELSE m.home_team_fouls END AS opponent_fouls,

                -- Posse de bola
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_possession ELSE m.away_team_possession END AS team_possession,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_possession ELSE m.home_team_possession END AS opponent_possession,

                -- Localização (casa/fora)
                CASE WHEN m.home_team_id = t.id THEN 
                    1 ELSE 0 END AS location,

                -- Gols
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_goals ELSE m.away_team_goals END AS team_goals,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_goals ELSE m.home_team_goals END AS opponent_goals,

                -- Chutes a gol
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_shots_on_target ELSE m.away_team_shots_on_target END AS team_shots_on_target,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_shots_on_target ELSE m.home_team_shots_on_target END AS opponent_shots_on_target,

                -- Cartões amarelos
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_yellow_cards ELSE m.away_team_yellow_cards END AS team_yellow_cards,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_yellow_cards ELSE m.home_team_yellow_cards END AS opponent_yellow_cards,

                -- Cartões vermelhos
                CASE WHEN m.home_team_id = t.id THEN 
                    m.home_team_red_cards ELSE m.away_team_red_cards END AS team_red_cards,
                CASE WHEN m.home_team_id = t.id THEN 
                    m.away_team_red_cards ELSE m.home_team_red_cards END AS opponent_red_cards
            FROM matches m
            JOIN teams t ON (t.id = m.home_team_id OR t.id = m.away_team_id)
            WHERE m.league_id = {league_id}
            AND m.status = '1'
            LIMIT {window_size}
        ) AS raw_fouls_league_data
        """
        return self.read_from_db(query)
    def prepare_data_for_model(self, home_id: int, away_id: int, window_size: int = 5):
        '''
        Prepara os dados do modelo para treino
        ''' 
        home_df = self.get_fouls_features(home_id, window_size)
        home_df = home_df.groupBy().agg(
            avg("team_fouls").alias("home_team_fouls"),
            avg("opponent_fouls").alias("home_opponent_fouls"), 
            avg("team_possession").alias("home_team_possession"),
            avg("opponent_possession").alias("home_opponent_possession"),
            first("location").alias("home_location")
        )
        away_df = self.get_fouls_features(away_id, window_size)
        away_df = away_df.groupBy().agg(
            avg("team_fouls").alias("away_team_fouls"),
            avg("opponent_fouls").alias("away_opponent_fouls"),
            avg("team_possession").alias("away_team_possession"),
            avg("opponent_possession").alias("away_opponent_possession"),
            first("location").alias("away_location")
        )
        

        combined_df = home_df.crossJoin(away_df)

        feature_cols = [
            "home_team_fouls", "home_opponent_fouls", "home_team_possession",
            "home_opponent_possession", "home_location",
            "away_team_fouls", "away_opponent_fouls", "away_team_possession",
            "away_opponent_possession", "away_location"
        ]

        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        data = assembler.transform(combined_df).select("features")

        return data  
    def prepare_data_for_model_league(self, home_team_id: int, away_team_id: int, league_id: int, window_size: int = 1000):
        """
        Prepara os dados históricos de toda a liga para prever faltas em um confronto específico (time da casa vs time visitante) dentro de uma liga.
        """
        # Coleta os dados de faltas para todos os times da liga
        df = self.get_fouls_features_league(league_id)
        df = df.fillna(0)
        # Filtra os dados para o time da casa e pega os últimos 'window_size' jogos
        home_df = df.filter(col("team_id") == home_team_id) \
            .orderBy(col("data").desc()) \
            .limit(window_size) \
            .groupBy() \
            .agg(
                avg("team_fouls").alias("home_team_fouls"),
                avg("opponent_fouls").alias("home_opponent_fouls"),
                avg("team_possession").alias("home_team_possession"),
                avg("opponent_possession").alias("home_opponent_possession"),
                first("location").alias("home_location"),
                
                # Novas estatísticas
                avg("team_goals").alias("home_team_goals"),
                avg("opponent_goals").alias("home_opponent_goals"),
                avg("team_shots_on_target").alias("home_team_shots_on_target"),
                avg("opponent_shots_on_target").alias("home_opponent_shots_on_target"),
                avg("team_yellow_cards").alias("home_team_yellow_cards"),
                avg("opponent_yellow_cards").alias("home_opponent_yellow_cards"),
                avg("team_red_cards").alias("home_team_red_cards"),
                avg("opponent_red_cards").alias("home_opponent_red_cards")
            )
        df = df.fillna(0)
        # Filtra os dados para o time visitante e pega os últimos 'window_size' jogos
        away_df = df.filter(col("team_id") == away_team_id) \
            .orderBy(col("data").desc()) \
            .limit(window_size) \
            .groupBy() \
            .agg(
                avg("team_fouls").alias("away_team_fouls"),
                avg("opponent_fouls").alias("away_opponent_fouls"),
                avg("team_possession").alias("away_team_possession"),
                avg("opponent_possession").alias("away_opponent_possession"),
                first("location").alias("away_location"),
                
                # Novas estatísticas
                avg("team_goals").alias("away_team_goals"),
                avg("opponent_goals").alias("away_opponent_goals"),
                avg("team_shots_on_target").alias("away_team_shots_on_target"),
                avg("opponent_shots_on_target").alias("away_opponent_shots_on_target"),
                avg("team_yellow_cards").alias("away_team_yellow_cards"),
                avg("opponent_yellow_cards").alias("away_opponent_yellow_cards"),
                avg("team_red_cards").alias("away_team_red_cards"),
                avg("opponent_red_cards").alias("away_opponent_red_cards")
            )
        # Faz o cross join para combinar os dados de ambos os times
        combined_df = home_df.crossJoin(away_df)

        # Cria a coluna de target (fouls_total) somando as faltas de casa e fora
        combined_df = combined_df.withColumn(
            "fouls_total",
            col("home_team_fouls") + col("away_team_fouls")  # Soma das faltas totais
        )

        # Lista de features que serão usadas no modelo
        feature_cols = [
            'home_team_fouls', 'away_team_fouls',
            'home_team_possession', 'away_team_possession',
            'home_location', 'away_location',
            
            # Novas features
            'home_team_goals', 'away_team_goals',
            'home_team_shots_on_target', 'away_team_shots_on_target',
            'home_team_yellow_cards', 'away_team_yellow_cards',
            'home_team_red_cards', 'away_team_red_cards'
        ]

        # Vetorização das features
        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        assembled_df = assembler.transform(combined_df)
        print(combined_df.show())
        
        # Retorna o DataFrame com features e a variável alvo (fouls_total)
        return assembled_df.select("features", "fouls_total", "home_team_fouls", "away_team_fouls") 
    def prepare_training_data_league(self, league_id, window_size: int = 1000):
        """
        Prepara os dados históricos de toda a liga para treinar o modelo de previsão de faltas.
        Utiliza os dados já unificados por partida (time + adversário).
        """
        # Coleta os dados de faltas para todos os times da liga
        df = self.get_fouls_features_league(league_id)
        
        # Define as features que serão utilizadas
        feature_cols = [
            "team_fouls", "opponent_fouls",
            "team_possession", "opponent_possession", "fouls_total",
            "location",
            
            # Novas features
            "team_goals", "opponent_goals",
            "team_shots_on_target", "opponent_shots_on_target",
            "team_yellow_cards", "opponent_yellow_cards",
            "team_red_cards", "opponent_red_cards"
        ]
        
        # Define a variável alvo
        df = df.withColumn("fouls_total", col("team_fouls") + col("opponent_fouls"))
        # Remover todas as linhas com valores nulos em qualquer coluna
        df = df.dropna()
        # Vetoriza as features
        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        assembled_df = assembler.transform(df)

        # Retorna o DataFrame com features e target
        return assembled_df.select("features", "fouls_total")        
    def _prepare_training_data(self, home_team_id: int, away_team_id: int, window_size: int = 1000):
        """Prepara os dados históricos para treinar o modelo de previsão de faltas"""
        
        # Coleta as features para os dois times envolvidos na partida
        home_df = self.get_fouls_features(home_team_id, window_size)
        away_df = self.get_fouls_features(away_team_id, window_size)
        
        for colname in home_df.columns:
            if colname not in ['match_id', 'data']:
                home_df = home_df.withColumnRenamed(colname, f'home_{colname}')
        for colname in away_df.columns:
            if colname not in ['match_id', 'data']:
                away_df = away_df.withColumnRenamed(colname, f'away_{colname}')
        
        # Faz o cross join para combinar os dados de ambos os times
        combined_df = home_df.crossJoin(away_df)
        # Coluna alvo (fouls_total)
        combined_df = combined_df.withColumn(
            "fouls_total",
            col("home_team_fouls") + col("away_team_fouls") 
        )
        
        # Lista de features para o modelo (sem incluir as colunas 'fouls_total')
        feature_cols = [
            'home_team_fouls', 'away_team_fouls',
            'home_team_possession', 'away_team_possession',
            'home_location', 'away_location',
            
            # Novas features
            'home_team_goals', 'away_team_goals',
            'home_team_shots_on_target', 'away_team_shots_on_target',
            'home_team_yellow_cards', 'away_team_yellow_cards',
            'home_team_red_cards', 'away_team_red_cards'
        ]

        # Vetorização
        assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")
        assembled_df = assembler.transform(combined_df)

        # Retorna o DataFrame com features e target
        return assembled_df.select("features", "fouls_total")

    
    