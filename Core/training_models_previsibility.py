from spark_manager import SparkManager
import numpy as np
import scipy.stats as st






if __name__ == '__main__':
    spark = SparkManager()
    
    leagues = spark.load_leagues().collect()
    models =  ['fouls', 'corners', 'yellow_cards', 'goals']
    spark.load_stat_mapping()
    for model_name in models:
        for league in leagues:
            league_id = league.id
            spark.load_stat_mapping()
            model_path = f"models/randomForest/rf_{model_name}_{league_id}"
            print("###Preparando os dados para treino###")
            train_data = spark.prepare_training_data(league_id,model_name)
            
            # Treina o modelo com os dados históricos

            model, rmse = spark.train_random_forest(train_data)
            print(f"Salvando {model_path}")
            model.write().overwrite().save(model_path)
            
  
        


    