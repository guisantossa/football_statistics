from football_ml import MatchProbabilityPredictor 
import numpy as np
import scipy.stats as st
from concurrent.futures import ThreadPoolExecutor, as_completed
import os
import sys
from pathlib import Path
from tqdm import tqdm  # Para barra de progresso (opcional)





def train_and_save_model(predictor, league_id, model_name, op, max_games):
    """Função que será paralelizada para treinar e salvar um modelo"""
    try:
        # Cria uma nova instância para evitar problemas com Spark em threads
        local_predictor = predictor
        
        # Configura o caminho seguro
        real_op = '>' if op == 'gt' else '<'
        model_path = f"models/RandomForestClassifier/rf_{model_name}_{league_id}_{op}"
        if os.path.exists(model_path):
            return (league_id, model_name, op, "SKIPPED (already exists)")
        # Cria diretório se não existir
        os.makedirs(os.path.dirname(model_path), exist_ok=True)
        
        # Treina e salva
        local_predictor.train_classifier_model(league_id, model_name, real_op, max_games)
        local_predictor.save_model(model_name, model_path, real_op)
        
        return (league_id, model_name, real_op, "SUCCESS")
    except Exception as e:
        return (league_id, model_name, real_op, f"ERROR: {str(e)}")



if __name__ == '__main__':
    
    # Configuração
    MAX_WORKERS = 8  # Ajuste conforme seus núcleos de CPU
    MAX_GAMES = 380
    
    predictor  = MatchProbabilityPredictor()
    
    leagues = [league.id for league in predictor.load_leagues().collect()]

    models_config = {
        'homegoals': {
            'ops': ['lt', 'gt']  
        },
        'awaygoals': {
            'ops': ['lt', 'gt']  
        },
        'goalsfirsthalf': {
            'ops': ['lt', 'gt']  
        },
        'corners': {
            'ops': ['lt', 'gt']  
        },
        'cards': {
            'ops': ['lt', 'gt']
        },
        'goals': {
            'ops': ['lt', 'gt']
        },
    }
    
    # Prepara todas as combinações de treinamento
    tasks = []
    for league_id in leagues:
        for model_name, config in models_config.items():
            for op in config['ops']:
                tasks.append((league_id, model_name, op))
    
    print(f"Total de modelos a treinar: {len(tasks)}")
    
    
    # Execução paralela
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        main_predictor  = MatchProbabilityPredictor()
        futures = [
            executor.submit(
                train_and_save_model,
                main_predictor,
                league_id,
                model_name,
                op,
                MAX_GAMES
            ) for league_id, model_name, op in tasks
        ]
        
        # Barra de progresso 
        for future in tqdm(as_completed(futures), total=len(futures)):
            result = future.result()
            if "SUCCESS"  not in result[3]:
                print(f"\nErro em {result[:3]}: {result[3]}")

    print("Treinamento de todos os modelos concluído!")
            
  
        


    