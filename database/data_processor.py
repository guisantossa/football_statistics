from .api_data_manager import APIDataManager
import time
from dotenv import load_dotenv
import os

# Carregar variáveis do .env
load_dotenv()

RAPID_API_KEY = os.getenv('RAPID_API_KEY2')
API_URL = os.getenv('API_URL')

class DataProcessor:
    
    def __init__(self):
        self.api_data_manager = APIDataManager()
    
    
    def insert_teams_season(self, league_id, year, is_current = True):
        '''
        Inserção dos times na temporada
        '''
        teams_data = self.api_data_manager.fetch_data(
            API_URL+f"teams?league={league_id}&season={year}"
        )
        if not teams_data or 'response' not in teams_data:
            print("Nenhum dado de times retornado pela API")
            return
    
        self.api_data_manager.insert_teams_season(teams_data['response'], league_id, year, is_current)
 
    def update_matches(self, league, date, year):
        '''
        Atualização das partidas realizadas da liga da temporada e da data
        '''
        matches = self.api_data_manager.fetch_data(API_URL+f"fixtures?date={date}&league={league}&season={year}")
        if len(matches['response']) > 0:
            self.api_data_manager.update_matches(matches['response'])
            for match in matches['response']:
                match_statistic =  self.api_data_manager.fetch_data(API_URL+f"fixtures/statistics?fixture={match['fixture']['id']}")
                self.api_data_manager.save_statistics(match_statistic['response'], match['fixture']['id'])
        else:
            print(f"Não Jogos a serem atualizados no dia {date} da liga {league} da temporada {year}")
            

