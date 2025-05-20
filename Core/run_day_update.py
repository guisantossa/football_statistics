import sys
from pathlib import Path
from processar_estatistica_acumulada import FootballStatsProcessor
from football_ml import MatchProbabilityPredictor
from concurrent.futures import ThreadPoolExecutor
import os
from tqdm import tqdm

# Import relativo (se o arquivo estiver em src/app/core)
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from database.data_processor import DataProcessor
from datetime import datetime, date
import concurrent.futures


def load_and_predict(predictor_class, model_path, league_id, model_type, match_id, home_id, away_id, last_n_games):
    """Função para carregar modelo e fazer previsão"""
    try:
        # Carrega o modelo específico
        predictor = predictor_class()

        existing_predict = predictor.check_match_db(match_id, model_type)
        
        if(existing_predict):
            print('Previsão já Existente')
            return None
        
        # Faz a previsão
        result = predictor.predict_probability_load(
            model_path = model_path,
            league_id=league_id,
            model_type=model_type,
            home_team_id=home_id,
            away_team_id=away_id,
            last_n_games=last_n_games
        )
        #print(result)
        return {
            'league_id': league_id,
            'match_id': match_id,
            'model_type': model_type,
            'model_path': model_path,
            'results': result,
            'status': 'SUCCESS'
        }
    except Exception as e:
        return {
            'league_id': league_id,
            'model_type': model_type,
            'error': str(e),
            'status': 'ERROR'
        }

def get_relevant_models(league_id, model_dir="models/RandomForestClassifier/"):
    """Retorna apenas os modelos relevantes para a liga especificada"""
    models = []
    for model_file in os.listdir(model_dir):
        if not model_file.startswith('rf_') or not os.path.isdir(os.path.join(model_dir, model_file)):
            continue
            
        parts = model_file.split('_')
        #if parts[1] not in ['homegoals', 'awaygoals', 'goalsfirsthalf']: # Adicione outros tipos de modelos conforme necessário
        #    continue
        
        
        try:
            file_league_id = int(parts[2])  # Estrutura: rf_[tipo]_[league_id]_[op]
            if file_league_id == league_id:
                model_type = parts[1]
                op = '>' if parts[3] == 'gt' else '<'
                models.append({
                    'path': os.path.join(model_dir, model_file),
                    'type': model_type,
                    'threshold': f"{op}"
                })
        except (IndexError, ValueError):
            continue
    return models

def update_prediction(predictor, match_id, league_id, home_id, away_id, last_n_games=5):
    """Atualiza previsões para um jogo específico"""
    # Encontra todos os modelos treinados
    relevant_models = get_relevant_models(league_id)
    
    
    
    if not relevant_models:
        print(f"Nenhum modelo encontrado para a liga {league_id}")
        return []
    
    # Processamento paralelo
    predictions = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as executor:
        futures = []
        for model in relevant_models:          
            futures.append(
                executor.submit(
                    load_and_predict,
                    MatchProbabilityPredictor,
                    model['path'],
                    league_id,
                    model['type'],
                    match_id,
                    home_id,
                    away_id,
                    last_n_games
                )
            )
        
        for future in concurrent.futures.as_completed(futures):
            if future.result() is not None:
                predictions.append(future.result())
    
    # Filtra previsões bem-sucedidas
    successful_predictions = [p for p in predictions if p['status'] == 'SUCCESS']

    # Salva no banco de dados
    if successful_predictions:
        #print(successful_predictions)
        high_prob_predictions = [
            {
                **pred,  # Mantém todos os dados originais (league_id, match_id, etc)
                'results': [res for res in pred['results'] if res['prob'] > 0.1]
            }
            for pred in successful_predictions
            if any(res['prob'] > 0.5 for res in pred['results'])
        ]
        
        if high_prob_predictions:  # Só salva se houver previsões acima do threshold
            
            predictor.save_predictions_to_db(
                predictions=high_prob_predictions,
                match_id=match_id,
                prediction_date=datetime.now()
            )
            print(f"Salvas {len(high_prob_predictions)} previsões com prob > 50%")

        else:
            print("Nenhuma previsão com probabilidade > 50% para salvar")
    
    return successful_predictions


    
    

def main():
    today = date.today()
    #today = '2025-05-11'
    print(f"Iniciando: Dia {today}")
    processor = DataProcessor()
    main_predictor = MatchProbabilityPredictor()
    #'''
    processor.update_date_matches(today)
    
    stats_processor = FootballStatsProcessor()
    
    
    leagues = [league.id for league in main_predictor.load_leagues().collect()]


    for league in leagues:
        print(f"Atualizando Partidas da Liga {league}")
        processor.insert_matches([league],[date.today().year],date.today())
        processor.update_all_pends_matches(league)
        stats_processor.update_next_round(league)
        
    
    #'''
    
    matches = main_predictor.get_matches_per_date(today)

    for match in matches:
        print(f"\nProcessando jogo {match['id']} (Liga: {match['league_id']})")
        # Obtém todas as previsões para o jogo
        update_prediction(
            predictor=main_predictor,
            match_id=match['id'],
            league_id=match['league_id'],
            home_id=match['home_team_id'],
            away_id=match['away_team_id'],
            last_n_games=5
        )

    print('Batendo previsões com resultados')
    main_predictor.compare_predicted_bets_combination()
    
    print(f"Previsões salvas.")
    #'''
    processor.insert_bets_by_date(today)
    

if __name__ == '__main__':
    main()
        


