from pyspark.sql import SparkSession
import pandas as pd
from pyspark.sql.types import StructType, StructField, FloatType

def prepare_training_data(spark, home_team_features, away_team_features):
    features = {
        'home_team_avg_fouls': float(home_team_features['avg_fouls']),
        'away_team_avg_fouls': float(away_team_features['avg_fouls']),
        'home_team_avg_possession': float(home_team_features['avg_possession']),
        'away_team_avg_possession': float(away_team_features['avg_possession']),
        'home_team_max_fouls': float(home_team_features['max_fouls']),
        'away_team_max_fouls': float(away_team_features['max_fouls']),
        'home_team_std_fouls': float(home_team_features['std_fouls']),
        'away_team_std_fouls': float(away_team_features['std_fouls']),
        'fouls_total': float(home_team_features['avg_fouls'] + away_team_features['avg_fouls']),
    }

    schema = StructType([
        StructField("home_team_avg_fouls", FloatType(), True),
        StructField("away_team_avg_fouls", FloatType(), True),
        StructField("home_team_avg_possession", FloatType(), True),
        StructField("away_team_avg_possession", FloatType(), True),
        StructField("home_team_max_fouls", FloatType(), True),
        StructField("away_team_max_fouls", FloatType(), True),
        StructField("home_team_std_fouls", FloatType(), True),
        StructField("away_team_std_fouls", FloatType(), True),
        StructField("fouls_total", FloatType(), True)
    ])

    df = pd.DataFrame([features]).astype('float32')
    return spark.createDataFrame(df, schema)

if __name__ == "__main__":
    spark = SparkSession.builder.master("local[*]").appName("Test").getOrCreate()

    home = {
        'avg_fouls': 13.0,
        'avg_possession': 51.0,
        'max_fouls': 17.0,
        'std_fouls': 1.5
    }

    away = {
        'avg_fouls': 10.0,
        'avg_possession': 47.0,
        'max_fouls': 14.0,
        'std_fouls': 2.0
    }

    df = prepare_training_data(spark, home, away)
    df.show()
