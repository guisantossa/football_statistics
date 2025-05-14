from football_ml import MatchProbabilityPredictor 
import numpy as np
import scipy.stats as st
from concurrent.futures import ThreadPoolExecutor, as_completed
import os
from tqdm import tqdm  # Para barra de progresso (opcional)


def train_test_and_save_model(predictor, league_id, model_name, op, value, max_games):
    """Função que será paralelizada para treinar e salvar um modelo"""
    try:
        # Cria uma nova instância para evitar problemas com Spark em threads
        local_predictor = predictor
        
        # Configura o caminho seguro
        real_op = '>' if op == 'gt' else '<'
        safe_value = str(value).replace('.', 'p')
        model_path = f"models/RandomForestClassifier/rf_{model_name}_{league_id}_{op}_{safe_value}"
        #if os.path.exists(model_path):
        #    return (league_id, model_name, op, value, "SKIPPED (already exists)")
        
        # Cria diretório se não existir
        os.makedirs(os.path.dirname(model_path), exist_ok=True)
        
        # Treina e salva
        local_predictor.train_classifier_model(league_id, model_name, real_op, value, max_games, test=True)
        local_predictor.save_model(model_name, model_path)
        
        return (league_id, model_name, real_op, value, "SUCCESS")
    except Exception as e:
        return (league_id, model_name, real_op, value, f"ERROR: {str(e)}")



if __name__ == '__main__':
    
    # Configuração
    MAX_WORKERS = 8  # Ajuste conforme seus núcleos de CPU
    MAX_GAMES = 380
    
    predictor  = MatchProbabilityPredictor()
    
    leagues = [league.id for league in predictor.load_leagues().collect()]

    models_config = {
        'corners': {
            'values': [6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5],
            'ops': ['lt', 'gt']  
        },
        'cards': {
            'values': [3.5, 4.5, 5.5, 6.5, 7.5],
            'ops': ['lt', 'gt']
        },
        'goals': {
            'values': [0.5, 1.5, 2.5, 3.5, 4.5, 5.5],
            'ops': ['lt', 'gt']
        },
    }
    
    # Prepara todas as combinações de treinamento
    tasks = []
    for league_id in leagues:
        for model_name, config in models_config.items():
            for op in config['ops']:
                for value in config['values']:
                    tasks.append((league_id, model_name, op, value))
    
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
                value,
                MAX_GAMES
            ) for league_id, model_name, op, value in tasks
        ]
        
        # Barra de progresso 
        for future in tqdm(as_completed(futures), total=len(futures)):
            result = future.result()
            if "SUCCESS"  not in result[4]:
                print(f"\nErro em {result[:4]}: {result[4]}")

    print("Treinamento de todos os modelos concluído!")
            
