from pyspark.sql.window import Window
from pyspark.sql import DataFrame
from pyspark.sql.functions import row_number, col, avg, regexp_extract, when, lower
import pyspark.sql.functions as F
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.spark_manager import SparkManager
import pandas as pd
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.evaluation import BinaryClassificationEvaluator, MulticlassClassificationEvaluator
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from pyspark.sql.types import StructType, StructField, DoubleType
from pyspark.ml import PipelineModel
import operator
from sqlalchemy import create_engine
from datetime import datetime

class TeamStatsCalculator(SparkManager):
    def __init__(self, app_name="FootballAnalytics"):
        super().__init__(app_name)
        
    def get_average_goals(self, league_id: int, team_id: int, is_home: bool = True, last_n_games: int = 5) -> float:
        """
        Calcula a média de gols marcados nos últimos `n` jogos por um time, 
        podendo escolher se os jogos são como mandante (home) ou visitante (away).
        """
        df_matches = self.read_from_db("matches")

        # Filtro baseado no time e se é casa ou visitante
        if is_home:
            df_filtered = df_matches.filter(
                (col("home_team_id") == team_id) & (col("status") == "1")  & (col("league_id") == league_id) # Finalizados
            ).select(
                col("data"),
                col("home_team_goals").alias("goals")
            )
        else:
            df_filtered = df_matches.filter(
                (col("away_team_id") == team_id) & (col("status") == "1") & (col("league_id") == league_id )
            ).select(
                col("data"),
                col("away_team_goals").alias("goals")
            )

        # Janela para pegar os últimos n jogos
        window_spec = Window.partitionBy("data").orderBy(col("data").desc())
        df_ranked = df_filtered.withColumn("row_number", row_number().over(window_spec))
        df_last_n = df_ranked.filter(col("row_number") <= last_n_games)

        # Cálculo da média
        result = df_last_n.select(avg("goals").alias("avg_goals")).collect()

        return result[0]["avg_goals"] if result else None
    
    def get_expected_goals_match(self, league_id: int, home_team_id: int, away_team_id: int, last_n_games: int = 5) -> float:
        """
        Retorna a soma das médias de gols dos dois times (casa + fora) nos últimos `n` jogos.
        """
        home_avg = self.get_average_goals(league_id, team_id=home_team_id, is_home=True, last_n_games=last_n_games)
        away_avg = self.get_average_goals(league_id, team_id=away_team_id, is_home=False, last_n_games=last_n_games)

        if home_avg is not None and away_avg is not None:
            return round(home_avg + away_avg, 2)
        return None

class MatchProbabilityPredictor(TeamStatsCalculator):
    
    def __init__(self, app_name="FootballAnalytics"):
        super().__init__(app_name)
        self._set_features()
    
    def _set_features(self):
        '''Definir feature e labels'''
        
        self.ops = {
             ">": operator.gt,
             "<": operator.lt
        }
        
        self.feature_config = {
            'goals': { 
                'features' : [
                    "home_team_goals", "away_team_goals",
                    "goal_diff",
                    "home_shot_eff",  "away_shot_eff", "home_def_pressure",
                    "shot_eff_diff", "weighted_goal_dominance",
                    #"threshold_proximity_0_1"
                ],
                'home_features_agg' : [
                    F.avg("home_team_goals").alias("home_team_goals"),
                    F.avg("away_team_goals").alias("away_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance"),
                ],
                'away_features_agg' : [
                    F.avg("home_team_goals").alias("home_team_goals"),
                    F.avg("away_team_goals").alias("away_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance")
                ],
                'label': 'goals_total',
                'label_expr': F.col("home_team_goals") + F.col("away_team_goals"),
                'value_init': 0.5,
                'predictions_number': 5
                
            },
            'goalsfirsthalf': { 
                'features' : [
                    "home_team_goals_secondhalf", "away_team_goals_secondhalf",
                    "home_team_goals_firsthalf", "away_team_goals_firsthalf",
                    "goal_diff",
                    "home_shot_eff",  "away_shot_eff", "home_def_pressure",
                    "shot_eff_diff", "weighted_goal_dominance"
                ],
                'home_features_agg' : [
                    F.avg("home_team_goals_secondhalf").alias("home_team_goals_secondhalf"),
                    F.avg("away_team_goals_secondhalf").alias("away_team_goals_secondhalf"),
                    F.avg("home_team_goals_firsthalf").alias("home_team_goals_firsthalf"),
                    F.avg("away_team_goals_firsthalf").alias("away_team_goals_firsthalf"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance")
                ],
                'away_features_agg' : [
                    F.avg("home_team_goals_secondhalf").alias("home_team_goals_secondhalf"),
                    F.avg("away_team_goals_secondhalf").alias("away_team_goals_secondhalf"),
                    F.avg("home_team_goals_firsthalf").alias("home_team_goals_firsthalf"),
                    F.avg("away_team_goals_firsthalf").alias("away_team_goals_firsthalf"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance")
                ],
                'label': 'goals_firsthalf_total',
                'label_expr': F.col("home_team_goals_firsthalf") + F.col("away_team_goals_firsthalf"),
                'value_init': 0.5,
                'predictions_number': 3
            },
            'homegoals': { 
                'features' : [
                    "home_team_goals",
                    "goal_diff",
                    "home_shot_eff",
                    "shot_eff_diff", "weighted_goal_dominance",
                ],
                'home_features_agg' : [
                    F.avg("home_team_goals").alias("home_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance"),
                ],
                'away_features_agg' : [
                    F.avg("home_team_goals").alias("home_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("home_shot_eff").alias("home_shot_eff"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance"),
                ],
                'label': 'home_team_goals',
                'label_expr': F.col("home_team_goals"),
                'value_init': 0.5,
                'predictions_number': 3
            },
            'awaygoals': { 
                'features' : [
                    "away_team_goals",
                    "goal_diff",  "away_shot_eff", "home_def_pressure",
                    "shot_eff_diff", "weighted_goal_dominance",
                ],
                'home_features_agg' : [
                    F.avg("away_team_goals").alias("away_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance"),
                ],
                'away_features_agg' : [
                     F.avg("away_team_goals").alias("away_team_goals"),
                    F.avg("goal_diff").alias("goal_diff"),
                    F.avg("away_shot_eff").alias("away_shot_eff"),
                    F.avg("home_def_pressure").alias("home_def_pressure"),
                    F.avg("shot_eff_diff").alias("shot_eff_diff"),
                    F.avg("weighted_goal_dominance").alias("weighted_goal_dominance"),
                ],
                'label': 'away_team_goals',
                'label_expr': F.col("away_team_goals"),
                'value_init': 0.5,
                'predictions_number': 3
            },
            'corners': { 
                'features': [ 
                    "corners_ratio",  "pressure_index", "corners_dominance",
                    "home_team_shots_on_target", "away_team_shots_on_target",
                    "home_team_corners", "away_team_corners",
                ],
                'home_features_agg' : [
                    F.avg("corners_ratio").alias("corners_ratio"),
                    F.avg("pressure_index").alias("pressure_index"),
                    F.avg("corners_dominance").alias("corners_dominance"),
                    F.avg("home_team_corners").alias("home_team_corners"),
                    F.avg("away_team_corners").alias("away_team_corners"),
                    F.avg("home_team_shots_on_target").alias("home_team_shots_on_target"),
                    F.avg("away_team_shots_on_target").alias("away_team_shots_on_target"),
                ],
                'away_features_agg' : [
                    F.avg("corners_ratio").alias("corners_ratio"),
                    F.avg("pressure_index").alias("pressure_index"),
                    F.avg("corners_dominance").alias("corners_dominance"),
                    F.avg("home_team_corners").alias("home_team_corners"),
                    F.avg("away_team_corners").alias("away_team_corners"),
                    F.avg("home_team_shots_on_target").alias("home_team_shots_on_target"),
                    F.avg("away_team_shots_on_target").alias("away_team_shots_on_target"),
                ],
                'label': 'corners_total',
                'label_expr': F.col("home_team_corners") + F.col("away_team_corners"),
                'value_init': 7.5,
                'predictions_number': 7
            },
            'cards': {
                'features' :[ 
                    "home_team_yellow_cards", "away_team_yellow_cards",
                    'home_aggressiveness_ratio', 'away_aggressiveness_ratio',
                    'home_cards_per_fouls', 'away_cards_per_fouls',
                    'away_agreesivity','home_agreesivity', 'vies_cards'
                ],
                'home_features_agg' : [
                    F.avg("home_team_yellow_cards").alias("home_team_yellow_cards"),
                    F.avg("home_cards_per_fouls").alias("home_cards_per_fouls"),
                    F.avg("home_aggressiveness_ratio").alias("home_aggressiveness_ratio"),
                    F.avg("home_agreesivity").alias("home_agreesivity"),
                    F.avg("vies_cards").alias("vies_cards")
                ],
                'away_features_agg' : [
                    F.avg("away_team_yellow_cards").alias("away_team_yellow_cards"),
                    F.avg("away_cards_per_fouls").alias("away_cards_per_fouls"),
                    F.avg("away_aggressiveness_ratio").alias("away_aggressiveness_ratio"),
                    F.avg("away_agreesivity").alias("away_agreesivity"),
                    F.avg("vies_cards").alias("vies_cards")
                ],
                'label': 'cards_total',
                'label_expr': F.col("home_total_cards_match") + F.col("away_total_cards_match") ,
                'value_init': 3.5,
                'predictions_number': 5
            }
        }
    
    def validate_model(self, last_n_games: int = 5, test_size: float = 0.2):
        """
        Realiza a validação do modelo utilizando o conjunto de treino e teste.
        Calcula a acurácia e outras métricas de avaliação.
        """
        # Carregar os dados dos jogos
        df = self.read_from_db("matches").limit(last_n_games)
        df = df.filter(F.col("status") == "1")  # Filtrar apenas jogos finalizados

        # Calcular o total de gols e criar a label (1 para Over 2.5, 0 para Under 2.5)
        df = df.withColumn("goals_total", F.col("home_team_goals") + F.col("away_team_goals"))
        df = df.withColumn("label", (F.col("goals_total") > 2.5).cast("int"))

        # Selecionar features relevantes para o modelo
        df = df.select(
            "home_team_goals", "away_team_goals",
            "home_team_shots", "away_team_shots",
            "home_team_goals_pro", "away_team_goals_pro",
            "home_team_goals_against", "away_team_goals_against",
            "home_team_rank", "away_team_rank",
            "label"
        ).dropna()  # Remover valores nulos

        # Dividir os dados em treino e teste
        train_data, test_data = df.randomSplit([1 - test_size, test_size])

        # Criar o vetor de features
        assembler = VectorAssembler(
            inputCols=[col for col in df.columns if col not in ("label")],
            outputCol="features"
        )

        # Transformar os dados
        train_data = assembler.transform(train_data)
        test_data = assembler.transform(test_data)

        # Inicializar o modelo RandomForest
        rf = RandomForestClassifier(labelCol="label", featuresCol="features", numTrees=100)

        # Treinar o modelo
        model = rf.fit(train_data)

        # Fazer previsões no conjunto de teste
        predictions = model.transform(test_data)

        # Avaliar o modelo com o BinaryClassificationEvaluator
        evaluator = BinaryClassificationEvaluator(labelCol="label", rawPredictionCol="prediction")
        accuracy = evaluator.evaluate(predictions)

        print(f"Acurácia do modelo: {accuracy:.4f}")
        
        # Adicionalmente, podemos usar mais métricas, como AUC ou F1-score, se necessário.
        # AUC - Área sob a Curva ROC
        auc_evaluator = BinaryClassificationEvaluator(labelCol="label", metricName="areaUnderROC")
        auc = auc_evaluator.evaluate(predictions)
        print(f"AUC do modelo: {auc:.4f}")

        # Calcular o F1-Score manualmente
        f1_score = self.calculate_f1_score(predictions)
        print(f"F1-Score do modelo: {f1_score:.4f}")
        
    def calculate_f1_score(self, predictions):
        """
        Calcula o F1-Score com base nas previsões do modelo.
        """
        # Contagem de TP, FP, FN, TN
        tp = predictions.filter((col("prediction") == 1) & (col("label") == 1)).count()
        fp = predictions.filter((col("prediction") == 1) & (col("label") == 0)).count()
        fn = predictions.filter((col("prediction") == 0) & (col("label") == 1)).count()
        tn = predictions.filter((col("prediction") == 0) & (col("label") == 0)).count()

        # Precisão e Revocação
        precision = tp / (tp + fp) if (tp + fp) != 0 else 0
        recall = tp / (tp + fn) if (tp + fn) != 0 else 0

        # F1-Score
        f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) != 0 else 0
        return f1_score
    
    def get_matches(self, league_id, home_team_id: int, away_team_id: int, last_n_games: int = 5) -> dict:
        """
        Função para pegar os dados de um jogo específico, com base nos últimos N jogos e as estatísticas dos times.
        Retorna um dicionário para ser usado no modelo de previsão.
        """
        df = self.read_from_db("matches_ml").filter((F.col("league_id") == league_id))
        
        # Selecionar os últimos N jogos para cada time
        home_games = df.filter(F.col("home_team_id") == home_team_id).orderBy(F.col("data").desc()).limit(last_n_games)
        away_games = df.filter(F.col("away_team_id") == away_team_id).orderBy(F.col("data").desc()).limit(last_n_games)
        
        home_games = home_games.na.fill(0)
        away_games = away_games.na.fill(0)
        
        return home_games, away_games
    
    def train_classifier_model_old(self, league_id, model_type, op, value, last_n_games: int = 5):
        """
        Treina o modelo RandomForest para prever a probabilidade de Over / Under Value model_type
        """
        
        # Carregar os dados dos jogos
        df = self.read_from_db("matches").filter(F.col("league_id") == league_id).limit(last_n_games)
        df = df.filter(F.col("status") == "1")  # Filtrar apenas jogos finalizados

        # Calcular o total de gols e criar a label (1 para Over 2.5, 0 para Under 2.5)
        
        df = df.withColumn(self.feature_config[model_type]['label'], self.feature_config[model_type]['label_expr'])
        df = df.withColumn("label", self.ops[op](F.col(self.feature_config[model_type]['label']), F.lit(value)).cast("int"))

        # Selecionar features relevantes para o modelo
        df = df.select(
            *self.feature_config[model_type]['features'],
            "label"
        ).dropna()  # Remover valores nulos

        # Criar o vetor de features
        assembler = VectorAssembler(
            inputCols=[col for col in df.columns if col not in ("label")],
            outputCol="features"
        )

        assembled = assembler.transform(df)

        # Inicializar o modelo RandomForest
        rf = RandomForestClassifier(labelCol="label", featuresCol="features", numTrees=100)
        
        param_grid, evaluator =  self._get_default_validator_params(rf)
       
        # Configurar o CrossValidator
        cv = CrossValidator(
            estimator=rf,
            estimatorParamMaps=param_grid,
            evaluator=evaluator,
            numFolds=3
        )

        # Treinar o modelo com validação cruzada
        cv_model = cv.fit(assembled)

        # Selecionar o melhor modelo
        best_model = cv_model.bestModel
        
        # Fazer previsões no conjunto de teste
        predictions = best_model.transform(assembled)
        self.auc = evaluator.evaluate(predictions)
        evaluator_f1 = MulticlassClassificationEvaluator(labelCol="label", metricName="f1")
        self.f1 = evaluator_f1.evaluate(predictions)
        
        # Armazenar o modelo e o assembler
        self.classifier_model = best_model
        self.assembler = assembler
    
    def undersampling(self: DataFrame, df, seed:int = 42) -> DataFrame:
        '''
        Função para balancear as classes do DataFrame, reduzindo a quantidade de amostras da classe majoritária.
        '''
        from functools import reduce
        
        # Passo 1: Contar amostras por classe
        class_counts = df.groupBy("label").count().collect()
        count_dict = {row["label"]: row["count"] for row in class_counts}

        # Define o tamanho alvo (ex: média ou mínima)
        min_samples = min(count_dict.values())
        ajuste = 0.8  # Ajuste o fator conforme necessário
        target_size = int(min_samples * ajuste)  # Ajuste o fator conforme necessário
        
        # Passo 3: Para cada classe, aplicar sample ou manter todas
        dfs_balanced = []
        for label, count in count_dict.items():
            if count <= target_size:
                # Mantém todas as amostras se já estiver abaixo do target
                df_class = df.filter(F.col("label") == label)
            else:
                # Calcula a fração dinâmica para reduzir ao target
                fraction = target_size / count
                df_class = df.filter(F.col("label") == label).sample(
                    fraction=fraction, 
                    seed=seed
                )
            dfs_balanced.append(df_class)
        
        # Passo 4: Unir todos os DataFrames
        return reduce(DataFrame.unionAll, dfs_balanced)
          
    def train_classifier_model(self, league_id, model_type, op, last_n_games: int = 5):
        """
        Treina o modelo RandomForest para prever a probabilidade de Over / Under Value model_type
        """
        from functools import reduce
        
        # Carregar os dados dos jogos
        self.spark.sparkContext.setLogLevel("ERROR")
        df = self.read_from_db("matches_ml").filter(F.col("league_id") == league_id).limit(last_n_games)


        feature_config = self.feature_config[model_type]
        # Calcular o total de gols e criar a label (1 para Over 2.5, 0 para Under 2.5)
        
        df = df.withColumn(feature_config['label'], feature_config['label_expr'])

        # Configurações
        pred_num = feature_config['predictions_number']
        value_init = feature_config['value_init']
        label_col = feature_config['label']

        # Inicializa com valor padrão
        label_column = F.lit(0)

        # Construção das condições
        if op == '>':
            # ORDEM CRESCENTE para '>' (0.5, 1.5, 2.5, 3.5, 4.5)
            thresholds = [value_init + i for i in range(pred_num)]
            for i, threshold in enumerate(thresholds, 1):
                label_column = F.when(F.col(label_col) > threshold, i).otherwise(label_column)
        else:
            # ORDEM CRESCENTE para '<' (0.5, 1.5, 2.5, 3.5, 4.5)
            thresholds = [value_init + i for i in reversed(range(pred_num))]
            for i, threshold in enumerate(thresholds, 1):
                label_column = F.when(F.col(label_col) < threshold, i).otherwise(label_column)

        # Aplica ao DataFrame
        df = df.withColumn("label", label_column)
        '''
        # Verificação
        print("\nThresholds aplicados:")
        for i, threshold in enumerate(thresholds, 1):
            print(f"Label {i}: {op} {threshold}")

        print("\nDistribuição das labels:")
        df.groupBy("label").count().orderBy("label").show()
        
        #print("Destribuição das features")
        #df.select([F.mean(col).alias(f'mean_{col}') for col in feature_config["features"]]).show()
        #''' 
        

        # Aplica ao DataFrame
        df = df.withColumn("label", label_column)
        
        # 3. Balanceamento (undersampling/oversampling) ✅ <<< NOVO!
        
        #df = self.undersampling(df)
        df = self.remove_insignificant_classes(df, threshold_ratio=3.0)
        # Mostra a nova distribuição
        #print("\nDistribuição das labels após balanceamento:")
        #df.groupBy("label").count().orderBy("label").show()
        #exit()
        
        df = df.select(
            *feature_config['features'],
            "label"
        ).na.fill(0)  # Remover valores nulos
        
        #df = self.winsorize(df, feature_config['features'], lower_pct=0.01, upper_pct=0.99)
        
        if df.count() == 0:
            raise ValueError("O DataFrame de treinamento está vazio após processamento.")
        # Criar o vetor de features
        assembler = VectorAssembler(
            inputCols=[col for col in df.columns if col not in ("label")],
            outputCol="features"
        )

        assembled = assembler.transform(df)
        
        # Inicializar o modelo RandomForest
        ###GOALS
        #rf = RandomForestClassifier(maxDepth=15, minInstancesPerNode=2, labelCol="label",  featuresCol="features", numTrees=100, featureSubsetStrategy="log2", impurity="entropy")
        if df.count() == 0:
            raise ValueError("O DataFrame de treinamento está vazio após processamento.")
        
        rf = RandomForestClassifier(maxDepth=15, minInstancesPerNode=2, labelCol="label",  featuresCol="features", numTrees=100, featureSubsetStrategy="log2", impurity="entropy")
        
        param_grid =  param_grid = ParamGridBuilder() \
            .addGrid(rf.numTrees, [50, 100, 200]) \
            .addGrid(rf.maxDepth, [5, 6, 8, 10]) \
            .addGrid(rf.minInstancesPerNode, [5, 10, 20]) \
            .build()
        
        evaluator = MulticlassClassificationEvaluator(labelCol="label", predictionCol="prediction", metricName="accuracy")
       
        # Configurar o CrossValidator
        cv = CrossValidator(
            estimator=rf,
            estimatorParamMaps=param_grid,
            evaluator=evaluator,
            numFolds=3
        )
        
        # Treinar o modelo com validação cruzada
        cv_model = cv.fit(assembled)

        # Selecionar o melhor modelo
        best_model = cv_model.bestModel
        
        #print("Melhores parâmetros:")
        #print(best_model.extractParamMap())
        '''
        print("Importância das features:")
        importances = best_model.featureImportances.toArray()
        feature_names = [col for col in df.columns if col not in ("label")]
        for name, importance in zip(feature_names, importances):
            print(f"{name}: {importance:.4f}")
            
        # Distribuição das classes
        print("\nDistribuição das classes após previsão:")
        df.groupBy("label").count().show()
        #'''

        predictions = best_model.transform(assembled)
        
        
        '''
        print("Matriz de confusão:")
        predictions.groupBy("label", "prediction").count().orderBy("label", "prediction").show() 
        #'''
        self.auc = evaluator.evaluate(predictions)

        evaluator_f1 = MulticlassClassificationEvaluator(labelCol="label", metricName="f1")

        self.f1 = evaluator_f1.evaluate(predictions)
        #print(f"AUC: {self.auc:.4f}")
        #print(f"F1-Score: {self.f1:.4f}")
        
        # Armazenar o modelo e o assembler
        self.classifier_model = best_model
        self.assembler = assembler

    def predict_probability_load(self, model_path, league_id, model_type, home_team_id: int, away_team_id: int, last_n_games = 5):
        """
        Prever a probabilidade de alguma feature usando o modelo RandomForest treinado
        """
        self.spark.sparkContext.setLogLevel("ERROR")
        
        parts = model_path.split('_')
        op = '>' if parts[3] == 'gt' else '<'
        
        self.load_model(model_path)
        if not hasattr(self, "pipeline_model"):
            raise Exception("Modelo ainda não treinado. Execute train_classifier_model primeiro.")

        # Obter o match_example utilizando a função get_match_example
        home_games, away_games = self.get_matches(league_id, home_team_id, away_team_id, last_n_games)
        feature_config = self.feature_config[model_type]
        
        # Agregar as estatísticas para o time da casa e visitante
        home_stats = home_games.agg(
            *feature_config['home_features_agg'],
            
        ).collect()[0]
        
        away_stats = away_games.agg(
            *feature_config['away_features_agg'],
        ).collect()[0]
        
        # Monta dinamicamente o dicionário com os valores corretos de cada time
        
        match = {}
        for feat in feature_config['features']:
            if feat.startswith("home_"):
                match[feat] = float(home_stats[feat]) if home_stats[feat] is not None else None
            elif feat.startswith("away_"):
                match[feat] = float(away_stats[feat]) if away_stats[feat] is not None else None
        

        # Criar um DataFrame com a linha do jogo
        schema = StructType([
            StructField(feat, DoubleType(), True)
            for feat in feature_config['features']
        ])
        
        df = self.spark.createDataFrame([match], schema=schema).na.fill(0)
                
        # Fazer a previsão com o modelo carregado
        result = self.pipeline_model.transform(df).select("probability").first()        
        
        prob_list = result['probability'].toArray().tolist()

        inverso ='<' if op == '>' else '>'
        class_names = {
            0: f"{model_type} {inverso} {feature_config['value_init']}",
            1: f"{model_type} {op} {feature_config['value_init']}",
            2: f"{model_type} {op} {feature_config['value_init'] + 1}",
            3: f"{model_type} {op} {feature_config['value_init'] + 2}",
            4: f"{model_type} {op} {feature_config['value_init'] + 3}",
            5: f"{model_type} {op} {feature_config['value_init'] + 4}",
            6: f"{model_type} {op} {feature_config['value_init'] + 5}",
            7: f"{model_type} {op} {feature_config['value_init'] + 6}",
            8: f"{model_type} {op} {feature_config['value_init'] + 7}",
            9: f"{model_type} {op} {feature_config['value_init'] + 8}",
        }  
        
        results = []
        last = 0.0
        cumul = 0.0
        prob_list = prob_list[1:]
        # Adiciona a probabilidade cumulativa
        if(op == '>'):
            for i, prob in reversed(list(enumerate(prob_list))):
                cumul = prob + last
                results.append({
                    "classe": class_names.get(i+1, f"Classe {i+1}"),
                    "prob": cumul
                })
                last = cumul  # Atualiza o last
        else:
            for i, prob in enumerate(prob_list):
                cumul = prob + last
                results.append({
                    "classe": class_names.get(i+1, f"Classe {i+1}"),
                    "prob": cumul
                })
                last = cumul

        # Inverter para deixar da classe 0 até 6
        results = list(reversed(results))
        if model_type == 'homegoals':
            away_team_id = None
        elif model_type == 'awaygoals':
            home_team_id = None
            
            
        results =  self.get_confiability(results, league_id, model_type, home_team_id, away_team_id, 10)

        return results 
        
    def predict_probability(self, league_id, model_type, op, home_team_id: int, away_team_id: int, last_n_games = 5):
        """
        Prever a probabilidade de alguma feature usando o modelo RandomForest treinado
        """

        if not hasattr(self, "classifier_model"):
            raise Exception("Modelo ainda não treinado. Execute train_classifier_model primeiro.")

        # Obter o match_example utilizando a função get_match_example
        home_games, away_games = self.get_matches(league_id, home_team_id, away_team_id, last_n_games)
        feature_config = self.feature_config[model_type]

        # Agregar as estatísticas para o time da casa e visitante
        home_stats = home_games.agg(
            *feature_config['home_features_agg']
        ).collect()[0]
        
        away_stats = away_games.agg(
            *feature_config['away_features_agg']
        ).collect()[0]
        
        '''
        for col_name in feature_config['features']:
            print(f"{col_name}: {home_games.filter(F.col(col_name).isNull()).count()} nulls")
        exit()
        #'''
        # Monta dinamicamente o dicionário com os valores corretos de cada time
        
        match = {}
        for feat in feature_config['features']:
            if feat.startswith("home_"):
                match[feat] = float(home_stats[feat]) if home_stats[feat] is not None else None
            elif feat.startswith("away_"):
                match[feat] = float(away_stats[feat]) if away_stats[feat] is not None else None

        
        # Criar um DataFrame com a linha do jogo
        schema = StructType([
            StructField(feat, DoubleType(), True)
            for feat in feature_config['features']
        ])
        df = self.spark.createDataFrame([match], schema=schema).na.fill(0)

        # Aplicar o assembler para preparar as features
        assembled = self.assembler.transform(df)

        # Realizar a previsão com o modelo
        result = self.classifier_model.transform(assembled)

        # Obter a coluna de probabilidade
        result = result.select("probability").first()

        prob_list = result['probability'].toArray().tolist()


        inverso ='<' if op == '>' else '>'
        
        class_names = {
            0: f"{model_type} {inverso} {feature_config['value_init']}",
            1: f"{model_type} {op} {feature_config['value_init']}",
            2: f"{model_type} {op} {feature_config['value_init'] + 1}",
            3: f"{model_type} {op} {feature_config['value_init'] + 2}",
            4: f"{model_type} {op} {feature_config['value_init'] + 3}",
            5: f"{model_type} {op} {feature_config['value_init'] + 4}",
            6: f"{model_type} {op} {feature_config['value_init'] + 5}",
            7: f"{model_type} {op} {feature_config['value_init'] + 6}",
            8: f"{model_type} {op} {feature_config['value_init'] + 7}",
            9: f"{model_type} {op} {feature_config['value_init'] + 8}",
        }        
        print(f"Probabilidades: {prob_list}")
        results = []
        last = 0.0
        cumul = 0.0
        prob_list = prob_list[1:]
        # Adiciona a probabilidade cumulativa
        if(op == '>'):
            for i, prob in reversed(list(enumerate(prob_list))):
                cumul = prob + last
                results.append({
                    "classe": class_names.get(i+1, f"Classe {i+1}"),
                    "prob": cumul
                })
                last = cumul  # Atualiza o last
        else:
            for i, prob in enumerate(prob_list):
                cumul = prob + last
                #print(f'Classe {class_names.get(i+1, f"Classe {i+1}")} valor {prob}')
                results.append({
                    "classe": class_names.get(i+1, f"Classe {i+1}"),
                    "prob": cumul
                })
                last = cumul

        # Inverter para deixar da classe 0 até 6
        results = list(reversed(results))

        if model_type == 'homegoals':
            away_team_id = None
        elif model_type == 'awaygoals':
            home_team_id = None
              
        results =  self.get_confiability(results, league_id, model_type, home_team_id, away_team_id, last_n_games)

        return results 
    
    def winsorize(self, df, cols, lower_pct=0.01, upper_pct=0.99):
        """
        Aplica winsorização nas colunas, truncando valores extremos para percentis definidos.

        Args:
            df: DataFrame do Spark
            cols: Lista de colunas para tratar
            lower_pct: Percentil inferior (default 1%)
            upper_pct: Percentil superior (default 99%)
        """
        for col in cols:
            lower, upper = df.approxQuantile(col, [lower_pct, upper_pct], 0.05)
            df = df.withColumn(
                col,
                F.when(F.col(col) < lower, lower)
                .when(F.col(col) > upper, upper)
                .otherwise(F.col(col))
            )
        return df

    def remove_outliers_iqr(self, df, cols, k=1.5):
        """
        Remove outliers de um DataFrame baseado no intervalo interquartil (IQR).
        
        Args:
            df: DataFrame do Spark
            cols: Lista de colunas a tratar
            k: Multiplicador do IQR para definir limites
        """
        for col in cols:
            q1, q3 = df.approxQuantile(col, [0.25, 0.75], 0.05)
            iqr = q3 - q1
            lower_bound = q1 - k * iqr
            upper_bound = q3 + k * iqr
            df = df.filter((F.col(col) >= lower_bound) & (F.col(col) <= upper_bound))
        return df
    
    def save_model(self, model_type: str, model_path: str, op: str ):
        import sys
        from pathlib import Path
        sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
        from database.crud import CRUDModelPrediction, CRUDModelPredictionReview
        from database.db import ModelPredictions, ModelPredictionReviews, get_db
        
        
        
        db = get_db()
        """
        Salva o modelo treinado e o assembler em um diretório.
        
        Args:
            model_type (str): Tipo do modelo ('goals', 'corners', 'cards').
            model_path (str): Caminho onde o modelo será salvo.
        """
        if not hasattr(self, "classifier_model"):
            raise Exception("Modelo ainda não treinado. Execute train_classifier_model primeiro.")
        
        # Criar um PipelineModel incluindo o assembler e o modelo
        pipeline_model = PipelineModel(stages=[self.assembler, self.classifier_model])
        pipeline_model.write().overwrite().save(model_path)
        print(f"Modelo {model_type} salvo em {model_path}")
        try:
            # Supondo que você tenha uma função `save_model_to_db` no seu objeto ou algum módulo para interação com o banco
            model_predictions = {
                'name': f"{op}",
                'tipo': 'RandomForestClassifier',
                'target': self.feature_config[model_type]['label'],
                'features': self.feature_config[model_type]['features'],
                'path': model_path,
                'is_production': True,
                'created_at': datetime.now()  # ou qualquer outro dado relevante
            }
            
            # Aqui você pode usar uma função para inserir no banco de dados
            model_prediction_crud = CRUDModelPrediction(ModelPredictions)
            model_prediction = model_prediction_crud.create(db=db, obj_in=model_predictions)
            
            review_data = {
                'model_prediction_id': model_prediction.id,
                'type': "AUC",
                'value': self.auc,  # Exemplo de user_id, ajuste conforme necessário
                'date': datetime.now(),
                'comments': f"Modelo {model_type} treinado com sucesso. AUC: {self.auc}"
            }
            model_prediction_review_crud = CRUDModelPredictionReview(ModelPredictionReviews)
            model_prediction_review_crud.create(db=db, obj_in=review_data)
            
            review_data = {
                'model_prediction_id': model_prediction.id,
                'type': "F1-Score",
                'value': self.f1,  # Exemplo de user_id, ajuste conforme necessário
                'date': datetime.now(),
                'comments': f"Modelo {model_type} treinado com sucesso. AF1-Score: {self.f1}"
            }
            model_prediction_review_crud.create(db=db, obj_in=review_data)
        except Exception as e:
            print(f"Erro ao salvar o modelo no banco de dados: {str(e)}")

    def load_model(self, model_path: str):
        """
        Carrega um modelo salvo.
        
        Args:
            model_path (str): Caminho onde o modelo foi salvo.
        """
        self.pipeline_model = PipelineModel.load(model_path)
        #print(f"Modelo carregado de {model_path}")

    def get_predictions_matches(self, match_id):
        '''Consulta as previsões do jogo'''
        
        query = (f'''
            (with teams_match as(
                select m.id, h.id home_id, a.id away_id, h.name home, a.name away, m.home_team_goals, m.away_team_goals, l.name league, home_team_rank, away_team_rank from matches m
                    join teams h on (h.id = m.home_team_id)
                    join teams a on (a.id = m.away_team_id)
                    join leagues l on (m.league_id = l.id)
                where m.id = {match_id}
            ),
            pred_bet as (
                select match_id, bt.name bet_type, valor, probabilidade, confianca from predictions p 
                    join bet_types bt on (bt.id = p.bet_type_id)
                where match_id = {match_id} and probabilidade > 0.7 and confianca > 0.5
            )
            select match_id, home_id, away_id, home, away, 
            home_team_rank, away_team_rank, bet_type, confianca, 
            valor, probabilidade, league from teams_match tm
                join pred_bet pb on (pb.match_id = tm.id)
            order by confianca desc, probabilidade desc
        ) as query ''')
        
        
        df = self.read_from_db(query)
        
        if df.count() == 0:
            return {}

        return [row.asDict() for row in df.collect()]
    
    def check_match_db(self, match_id, model_type):
        
        model_type = self.convert_model_type(model_type)

        try:
            first = self.read_from_db('predictions').filter((F.col('match_id') == match_id) & (F.col('bet_type_id') == model_type))
        except Exception as e:
            print(e)

        return 1 if first.count() > 0 else None
    
    def save_predictions_to_db(self, predictions, match_id, prediction_date):
        """
        Salva previsões no banco de dados
        Args:
            predictions: Lista de dicionários com os resultados
            match_id: ID do jogo no banco de dados
            prediction_date: Data da previsão
        """
        from dotenv import load_dotenv
        import os

        # Carregar variáveis do .env
        load_dotenv()
        DATABASE_URL = os.getenv("DATABASE_URL")
        # Converter para DataFrame Spark
        # Converter para pandas DataFrame
        valid_preds = [p for p in predictions if p['status'] == 'SUCCESS']
        if not valid_preds:
            return
        
        rows = []
        for pred in valid_preds:
            for res in pred['results']:
                classe = ' '.join(res['classe'].split(' ')[1:])  # Extrair a classe (ex: "goals > 2.5" -> "2.5")
                rows.append({
                    'match_id': pred['match_id'],
                    'bet_type_id': self.convert_model_type(pred['model_type']),
                    'valor': classe,
                    'probabilidade': float(res['prob']),
                    'confianca': float(res['confiabilidade']),
                    'date': prediction_date
                })
        
        if not rows:
            print("Nenhuma linha válida para salvar.")
            return
        
        pd_df = pd.DataFrame(rows)
        
        engine = create_engine(DATABASE_URL)
        
        try:
            # Salvar no banco
            pd_df.to_sql(
                name='predictions',
                con=engine,
                if_exists='append',
                index=False
            )
            
        except Exception as e:
            print(f"Erro ao salvar previsões: {str(e)}")
            # Fallback: salvar em arquivo
            pd_df.to_parquet(f"fallback_predictions/match_{match_id}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.parquet")
        finally:
            engine.dispose()
    
    def convert_model_type(self,model_type):
        ''' uma função para converter para o tipo de modelo ja cadastrado no banco'''
        
        bet_types = {
            'goals': 5,
            'corners': 45,
            'cards': 80,
            'goalsfirsthalf': 6,
            'homegoals': 16,
            'awaygoals': 17
        }
        
        return bet_types[model_type] if model_type in bet_types else None

    def get_avg(self, league_id: int, model_type:str, home_id:int = None, away_id:int = None):
        #Retorna o AVG do label_col da liga selecionada
        label_col = self.feature_config[model_type]['label']
        df = self.read_from_db('current_season_matches').filter((F.col('league_id') == league_id)).agg(F.avg(label_col).alias('avg'))
        return self.read_from_db('current_season_matches').filter((F.col('league_id') == league_id)).agg(F.avg(label_col).alias('avg')).collect()[0]['avg']
    
    def get_confiability(self, results, league_id, model_type, home_id,away_id, last_n_games = 5):
        '''
        Recebe uma lista de resultados (predições) e retorna confiabilidade baseada no histórico dos times.
        Recebe uma lista de resultados (predições) e retorna confiabilidade baseada em históricos, somados uns aos outros e com pesos.
        Cada item da lista deve conter:
        - 'classe': string como "goals > 2.5"
        - 'probabilidade_modelo': previsão do modelo (float entre 0 e 1)
        Retorna a lista com os campos 'confiabilidade' e 'confianca_ajustada'.
        '''

        home, away = self.get_matches(league_id,home_id,away_id,last_n_games)
        
        label_col = self.feature_config[model_type]['label']
        
        # Processa apenas o que existir (home ou away)
        if home is not None:
            home = home.withColumn(label_col, self.feature_config[model_type]['label_expr'])
        
        if away is not None:
            away = away.withColumn(label_col, self.feature_config[model_type]['label_expr'])
        
        # Define os matches a usar
        if home is not None and away is not None:
            all_matches = home.unionByName(away)
        elif home is not None:
            all_matches = home  # Só home
        else:
            all_matches = away  # Só away
        
        
        
        total_matches = last_n_games * (1 if home is None or away is None else 2)
        avg = self.get_avg(league_id, model_type)
        for result in results:
            
            #Em caso de predileções de > ou < pega a média geral do campeonato e bonifica com 3%
            
            classe = result['classe']  # Ex: "goals > 2.5"
            # Extrair operação e valor
            parts = classe.split(' ')
            op = parts[1]    # ">"
            valor = float(parts[2])

            # Construir a comparação
            comparison = F.col(label_col) > F.lit(valor) if op == '>' else F.col(label_col) < F.lit(valor)
            if op == '>':
                confianca = 0.03 if avg >= valor else - 0.03
            else:
                confianca = 0.03 if avg <= valor else - 0.03

            # Filtra os jogos que batem essa condição
            filtered = all_matches.filter(comparison)

            # Conta quantos jogos satisfazem
            count = filtered.count()
            empirical_prob = count / total_matches if total_matches > 0 else 0

            # Adiciona ao resultado a confiabilidade histórica
            #result['confiabilidade'] = round(empirical_prob, 3)
            result['confiabilidade'] = (((result['prob']*2) + round(empirical_prob, 3))/3) + confianca


        return results

    
    #def generate_combinations_bets(self, min_odds: float = 1.55, max_odds: float = 1.8, min_bets: int = 2, max_bets: int = 5, data: str = None, MAX_REPEATS=5):
    def generate_combinations_bets(
        self,
        odd_min:float = 1.05,
        min_odds: float = 1.55,
        max_odds: float = 1.8,
        min_bets: int = 2,
        max_bets: int = 5,
        num_bets: int = None,
        prob:float = 0.8,
        confianca:float = 0.70,
        data: str = None,
        top_n: int = 50,  # Novo parâmetro: manter apenas as N melhores combinações
        similarity_threshold: float = 0.6,  # Para eliminar combinações muito parecidas
        jogos_excluidos: list = None,
        jogos_incluidos: list = None,
        max_repeats_per_bet: int = 2
    ):
        """
        Gera combinações de apostas com base nas odds e no número de apostas.
        
        Args:
            max_odds (float): Limite máximo de odds para a combinação
            min_bets (int): Número mínimo de apostas na combinação
            max_bets (int): Número máximo de apostas na combinação
            data (str): Data no formato 'YYYY-MM-DD' para filtrar as apostas
        
        Returns:
            list: Lista de dicionários com as combinações válidas (não é mais DataFrame)
        """
        import itertools
        from collections import defaultdict
        
        # 1. Busca das apostas válidas
        bets_df = self.read_from_db("bets_mount").filter(
            (F.to_date("data") == data) &
            (F.col('probabilidade') >= prob) &  # Aumentei o filtro mínimo
            (F.col('confianca') >= confianca)&      # Confiança mais alta
            (F.col('odd') >= odd_min)  
        ) 
        
        if jogos_excluidos:
            bets_df = bets_df.filter(~F.col('match_id').isin(jogos_excluidos))
        
        if jogos_incluidos:
            bets_df = bets_df.filter(F.col('match_id').isin(jogos_incluidos))
        
        print(f"Total de apostas válidas encontradas: {bets_df.count()}")

        # 2. Organizar apostas por jogo
        bets_list = [
            {
                'match_id': row['match_id'],
                'home': row['home'],
                'away': row['away'],
                'data': str(row['data']),
                'value_bet': row['value_bet'],
                'market': row['valor'],
                'prob': float(row['probabilidade']),
                'confianca': float(row['confianca']),
                'odd': float(row['odd'])
            }
            for row in bets_df.collect()
        ]

        # 3. Gerar combinações válidas
        all_combinations = []
        
        comb_sizes = [num_bets] if num_bets else range(min_bets, max_bets + 1)
        
        # Para cada tamanho de combinação desejado
        for r in comb_sizes:
            # Gerar combinações de jogos
            for bet_combination in itertools.combinations(bets_list, r):
                
                # Calcular métricas
                total_odds = 1.0
                total_prob = 1.0
                total_conf = 0.0
                
                for bet in bet_combination:
                    total_odds *= bet['odd']
                    total_prob *= bet['prob']
                    total_conf += bet['confianca']
                
                avg_conf = total_conf / r
                
                # Aplicar filtros

                
                if min_odds <= total_odds <= max_odds:
                    all_combinations.append({
                        'combination_id': len(all_combinations) + 1,
                        'total_odds': total_odds,
                        'avg_probability': total_prob,
                        'avg_confidence': avg_conf,
                        'num_bets': r,
                        'bets': [
                        {
                            'match_id' : bet['match_id'],
                            'match': f"{bet['home']} vs {bet['away']}",
                            'bet': f"{bet['value_bet']} {bet['market']}",
                            'odd': bet['odd'],
                            'prob': bet['prob'],
                            'confianca': bet['confianca']
                        }
                        for bet in bet_combination
                    ]
                    })
        print(f"Total de combinações geradas: {len(all_combinations)}")
        
        # 3. Remover combinações muito parecidas
        def is_similar(comb1, comb2):
            bets1 = set((b['match_id'], b['bet']) for b in comb1['bets'])
            bets2 = set((b['match_id'], b['bet']) for b in comb2['bets'])
            intersection = bets1 & bets2
            ratio = len(intersection) / min(len(bets1), len(bets2))
            return ratio >= similarity_threshold

        filtered_combinations = []
        seen = []
        
        for comb in all_combinations:
            if not any(is_similar(comb, prev) for prev in seen):
                seen.append(comb)
                filtered_combinations.append(comb)

        print(f"Após filtrar combinações similares: {len(filtered_combinations)}")
        
        # 4. Limitar repetições de uma mesma bet
        from collections import Counter
        bet_counter = Counter()
        limited_combinations = []
        
        # 4. Ordenar por valor esperado
        filtered_combinations.sort(
            key=lambda x: (
                x['avg_probability'],  # Ordem primária
                x['avg_confidence'],   # Ordem secundária
                x['total_odds']        # Ordem terciária
            ),
            reverse=True
        )
        
        for comb in filtered_combinations:
            bets_in_comb = [(b['match_id'], b['bet']) for b in comb['bets']]

            # Verifica se alguma aposta já excedeu o número máximo permitido
            if all(bet_counter[bet] < max_repeats_per_bet for bet in bets_in_comb):
                limited_combinations.append(comb)
                for bet in bets_in_comb:
                    bet_counter[bet] += 1

        print(f"Após limitar repetições por bet (máx {max_repeats_per_bet}): {len(limited_combinations)}")
        
        

        return limited_combinations[:top_n]
        
    def compare_predicted_bets_combination(self):
        '''
            Função para verificar se as bets deram Green ou Red
        '''
        import sys
        from pathlib import Path
        sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
        from database.db import get_db, BetCombination, CombinationBet, Match
        session = get_db()
        
        bets = self.read_from_db('combination_bets').filter((F.col('result').isNull()) & (F.col('bet_status') == 'pending' )
                                                                                          )
                                                           
        if bets.count() == 0:
            return None
        #bets.show()
        # 2. Obter apenas os match_ids necessários
        match_ids_list = [row['match_id'] for row in bets.select('match_id').distinct().collect()]
        matches = self.read_from_db('matches_ml').filter(F.col('id').isin(match_ids_list) & (F.col('status') == '1'))
        
        bets_with_matches = bets.join(matches, bets.match_id == matches.id, how='inner')
        
        bets_with_matches = bets_with_matches.withColumn(
            'total_goals',
            col('home_team_goals') + col('away_team_goals')
        ).withColumn(
            'total_goals_firstHalf',
            col('home_team_goals_firstHalf') + col('away_team_goals_firstHalf')
        ).withColumn(
            'total_cards',
            col('home_total_cards_match') + col('away_total_cards_match')
        ).withColumn(
            'total_corners',
            col('home_team_corners') + col('away_team_corners')
        )
        
        bets_with_matches = bets_with_matches.withColumn(
            'line',
            regexp_extract(col('bet_type'), r'(?i)(Under|Over)\s+(\d+\.\d+)', 2).cast('float')
        )
        
        bets_with_matches = bets_with_matches.withColumn(
            'direction',
            lower(regexp_extract(col('bet_type'), r'(?i)(Under|Over)\s+(\d+\.\d+)', 1))
        )
        
        # 5. Verificar resultados com base no tipo de aposta
        # Define resultado com base no tipo de aposta
        bets_check = bets_with_matches.withColumn(
            'result',
            when(
                (col('bet_type').rlike('(?i)First Half')) &
                (((col('direction') == 'over') & (col('total_goals_firstHalf') > col('line'))) |
                ((col('direction') == 'under') & (col('total_goals_firstHalf') < col('line')))),
                'green'
            ).when(
                (col('bet_type').rlike('(?i)goals')) &
                (((col('direction') == 'over') & (col('total_goals') > col('line'))) |
                ((col('direction') == 'under') & (col('total_goals') < col('line')))),
                'green'
            ).when(
                (col('bet_type').rlike('(?i)cards')) &
                (((col('direction') == 'over') & (col('total_cards') > col('line'))) |
                ((col('direction') == 'under') & (col('total_cards') < col('line')))),
                'green'
            ).when(
                (col('bet_type').rlike('(?i)corners')) &
                (((col('direction') == 'over') & (col('total_corners') > col('line'))) |
                ((col('direction') == 'under') & (col('total_corners') < col('line')))),
                'green'
            ).otherwise('red')
        )
        #bets_check.select('id', 'bet_id', 'combination_id', 'match_name', 'bet_type', 'direction', 'line', 'total_goals', 'total_cards', 'total_corners', 'total_goals_firstHalf', 'result' ).show()
        bets_check_data = bets_check.select(
         'bet_id', 'result', 'combination_id'
        ).collect()
        for bet in bets_check_data:
            
            # Atualiza o resultado da aposta
            bet_to_update = session.query(CombinationBet).filter_by(bet_id=bet['bet_id']).first()
            
            if bet_to_update:
                # Verifica a condição do resultado e atualiza
                if bet['result'] == 'green':
                    bet_to_update.result = True
                else:
                    bet_to_update.result = False
                bet_to_update.bet_status = 'Complete'

                # Salva as mudanças no banco
                session.commit()


        bet_ids = list(set(bet['combination_id'] for bet in bets_check_data))
        
        for bid in bet_ids:
            all_bets = session.query(CombinationBet).filter_by(combination_id =bid).all()
            results = [b.result for b in all_bets]

            bet_comb = session.query(BetCombination).filter_by(combination_id =bid).first()
            if bet_comb:
                if all(r is True for r in results):
                    bet_comb.result = True
                else:
                    bet_comb.result = False
                bet_comb.bet_status = 'Complete'
                session.commit()
        # Finaliza a sessão
        session.close()
        
    def save_combinations_to_db(self,combinations, min_odds, max_odds):
        
        import sys
        from pathlib import Path
        sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
        from database.db import get_db, BetCombination, Match, CombinationBet
        session = get_db()
        errors = []
        print('Ele entrou aqui')
        try:
            for combo in combinations:
                new_combination = BetCombination(
                    total_odds=combo['total_odds'],
                    avg_probability=combo['avg_probability'],
                    avg_confidence=combo['avg_confidence'],
                    num_bets=combo['num_bets'],
                    min_odds=min_odds,
                    max_odds=max_odds
                )
                session.add(new_combination)
                session.flush()

                for bet in combo['bets']:
                    # Primeiro verifica se o jogo já existe
                    match = session.query(Match).filter_by(
                        id=bet['match_id']
                    ).first()
                    
                    if not match:
                        errors.append(f"❗ Partida não cadastrada: {bet['match_id']}")
                        continue

                    new_bet = CombinationBet(
                        combination_id=new_combination.combination_id,
                        match_id=bet['match_id'],
                        match_name=bet['match'],
                        bet_type=f"{bet['bet']} ",
                        odd=bet['odd'],
                        probability=bet['prob'],
                        confidence=bet['confianca']
                    )
                    session.add(new_bet)
            
            session.commit()
            return {"success": True, "errors": errors}
        
        except Exception as e:
            session.rollback()
            return {"success": False, "errors": [str(e)]}
        finally:
            session.close()
    
    def get_feature_importance(self, model_type: str):
        """
        Retorna a importância das features do modelo RandomForest.
        """
        if not hasattr(self, "pipeline_model"):
            raise Exception("Modelo ainda não treinado. Execute train_classifier_model primeiro.")
        
       # Pega a importância das features
        importances = self.pipeline_model.stages[-1].featureImportances

        # A lista de features que você usou para treinar
        feature_names = self.feature_config[model_type]['features']
        feature_names.append('matchday')
        # Agora junta tudo bonitinho
        importance_list = list(zip(feature_names, importances))

        # Ordena da mais importante para a menos importante
        importance_list_sorted = sorted(importance_list, key=lambda x: x[1], reverse=True)
        
        # Exibe
        for feature, importance in zip(feature_names, importances):
            print(f"Feature: {feature}, Importância: {importance:.4f}")
            
        importances_list = [(feature, importance) for feature, importance in zip(feature_names, importances)]
        importances_list.sort(key=lambda x: x[1], reverse=True)  # Ordenar por importância
        import matplotlib.pyplot as plt

        features, importances = zip(*importances_list)  # Separar nomes e valores

        plt.figure(figsize=(12, 6))
        plt.barh(features, importances, color="skyblue")
        plt.xlabel("Importância")
        plt.title("Importância das Features para o Modelo")
        plt.gca().invert_yaxis()  # Para o mais importante aparecer no topo
        plt.grid(True, axis='x', linestyle='--', alpha=0.7)
        plt.tight_layout()
        plt.show()
        
        threshold = 0.01  # define o mínimo de importância aceitável
        selected_features = [feature for feature, importance in importances_list if importance >= threshold]

        print(f"Features selecionadas: {selected_features}")
    
    def remove_insignificant_classes(self, df: DataFrame, threshold_ratio: float = 5.0) -> DataFrame:
        """
        Remove classes que são 'threshold_ratio' vezes menores que a segunda menor classe.
        
        Args:
            df: DataFrame do PySpark.
            threshold_ratio: Razão para considerar uma classe insignificante (padrão: 5.0).
        
        Returns:
            DataFrame filtrado ou original.
        """
        # Conta amostras por classe e ordena do menor para o maior
        class_counts = df.groupBy("label").count().orderBy("count").collect()
        
        if len(class_counts) < 2:
            return df  # Não há classes suficientes para comparar
        
        smallest_class = class_counts[0]["label"]
        smallest_count = class_counts[0]["count"]
        second_smallest_count = class_counts[1]["count"]
        
        # Verifica se a menor classe é 'threshold_ratio' vezes menor que a segunda menor
        if smallest_count * threshold_ratio < second_smallest_count:
            #print(f"Removendo label {smallest_class} (count={smallest_count}), pois é {threshold_ratio}x menor que a próxima classe.")
            return df.filter(F.col("label") != smallest_class)
        else:
            #print("Nenhuma classe removida: a menor classe não é insignificante.")
            return df    
        
if __name__ == "__main__":
    predictor = MatchProbabilityPredictor()
    
    #predictor.compare_predicted_bets_combination()
    #exit()
    #combinations = predictor.generate_combinations_bets(data='2025-05-14', min_odds= 1.55, max_odds=1.80, num_bets=3, top_n = 100, odd_min=1.10, max_repeats_per_bet=2 )
    #print(f"Número total de combinações {len(combinations)}")
    #predictor.save_combinations_to_db(combinations,min_odds=1.55,max_odds=1.80)
    
    '''for combo in combinations[:20]:
        print(f"\nCombinação #{combo['combination_id']}")
        print(f"Odds Total: {combo['total_odds']:.2f}")
        print(f"Probabilidade Média: {combo['avg_probability']:.2%} ---------  Confiabilidade Média: {combo['avg_confidence']:.2%}")
        print("Apostas:")
        for bet in combo['bets']:
            print(f"- {bet['match']}: {bet['bet']} (Odd: {bet['odd']:.2f}, Prob: {bet['prob']:.2%})")
    exit()
    '''
    home_team_id = 451  # ID do time da casa
    away_team_id = 453 # ID do time visitante
    league_id = 128
    model = 'goalsfirsthalf'
    op = 'gt' #<
    #op = 'gt' #>
    model_path = f'models/randomForestClassifier/rf_{model}_{league_id}_{op}'
    
    
    #op = '>' #<
    #op = '>' #>
    #predictor.load_model(model_path)
    #predictor.get_feature_importance(model)
    #exit()
    # Agora você pode usar match_example para previsões
    #print("treino do modelo")
    #predictor.train_classifier_model(league_id, model, op, last_n_games=380)
    #
    #predictor.save_model(model, model_path, op)
    
    print("previsão do modelo")
    #result = predictor.predict_probability_load(model_path, league_id, 'goals', home_team_id, away_team_id, last_n_games=5)
    results = predictor.predict_probability_load(league_id=league_id, model_path=model_path, model_type=model, home_team_id=home_team_id, away_team_id=away_team_id, last_n_games=5)
    for result in results:
        print(f"Classe: {result['classe']}, Probabilidade: {result['prob']}, Confiabilidade: {result['confiabilidade']}, Confianca Ajustada: {result.get('confianca_ajustada', 'N/A')}")
        


    
    