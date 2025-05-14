from spark_manager import SparkManager
import numpy as np
import scipy.stats as st

if __name__ == '__main__':
    spark = SparkManager()
    
    #spark.load_stat_mapping()
    
    #print("###Preparando os dados para treino###")
    #train_data = spark.prepare_training_data(71,'corners')
    
    # Treina o modelo com os dados históricos

    analise, home_media, away_media = spark.call_models(140,532,540,['corners'])
    print("### 🔍 **Análise de corners**")
    print(f"*Média Time da Casa:** `{home_media:.1f}")
    print(f"*Média Time da Visitante:** `{away_media:.1f}")
    print(f"**Previsão Total:** `{analise['predicao']:.2f}")
    print(f"**Melhor direção (tendência):** `{analise['melhor_aposta'].upper()}`")
    print(f"**Acertos:** `{analise['acertos']} ")
    print(f"**Erros:** `{analise['erros']}`")
    
    analise, home_media, away_media = spark.call_models(140,529,798,['yellow_cards'])
    print("### 🔍 **Análise de yellow_cards**")
    print(f"*Média Time da Casa:** `{home_media:.1f}")
    print(f"*Média Time da Visitante:** `{away_media:.1f}")
    print(f"**Previsão Total:** `{analise['predicao']:.2f}")
    print(f"**Melhor direção (tendência):** `{analise['melhor_aposta'].upper()}`")
    print(f"**Acertos:** `{analise['acertos']} ")
    print(f"**Erros:** `{analise['erros']}`")

    


    