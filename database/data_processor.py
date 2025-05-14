import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from database.api_data_manager import APIDataManager
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
    
    def insert_leagues(self):
        '''
        Inserção de Ligas
        '''
        leagues = []
        print(self.countries)
        for country in self.countries:
            leagues_data = self.api_data_manager.fetch_data(
                API_URL+f"leagues?country={country}&season={self.seasons[0]}"
            )
            print(API_URL+f"leagues?country={country}&season={self.seasons[0]}")
            if not leagues_data or 'response' not in leagues_data:
                print("Nenhum dado de times retornado pela API")
                return

            leagues.append(self.api_data_manager.save_league(leagues_data['response']))
        return leagues
    
    def insert_teams_country(self, countries):
        '''
        Inserção de times
        '''
        for country in countries:
            teams_data = self.api_data_manager.fetch_data(
                API_URL+f"teams?country={country}"
            )
            if not teams_data or 'response' not in teams_data:
                print("Nenhum dado de times retornado pela API")
                return
            
            self.api_data_manager.save_teams(teams_data['response'])
    
    def insert_teams_season(self, leagues, seasons):
        '''
        Inserção de times
        '''
        for league in leagues:
            for season in seasons:
                teams_data = self.api_data_manager.fetch_data(
                    API_URL+f"teams?league={league}&season={season}"
                )
                if not teams_data or 'response' not in teams_data:
                    print("Nenhum dado de times retornado pela API")
                    return
                
                self.api_data_manager.save_teams(teams_data['response'])
        
    def insert_season(self, year, country):
        '''
        Inserção de temporadas
        '''
        teams_season = self.api_data_manager.fetch_data(
            API_URL+f"leagues?country={country}&season={year}"
        )
        if not teams_season or 'response' not in teams_season:
            print("Nenhum dado de season retornado pela API")
            return
        self.api_data_manager.save_season(teams_season['response'], self.countries)    
        
    def update_all_pends_matches(self, league_id:int = None, repair:int=None):
        '''
        Atualiza as partidas já realizadas de dias passados
        '''
        if(repair):
            ids = self.api_data_manager.repair_matches_to_update(league_id)
        else:
            ids = self.api_data_manager.get_matches_to_update(league_id)
        url = f"fixtures?ids={ids}"
        matches = self.api_data_manager.fetch_data(API_URL+url)
        if len(matches['response']) > 0:
            self.api_data_manager.update_matches(matches['response'])
            for match in matches['response']:
                match_statistic =  self.api_data_manager.fetch_data(API_URL+f"fixtures/statistics?fixture={match['fixture']['id']}")
                if(len(match_statistic['response'])>0):
                    self.api_data_manager.save_statistics(match_statistic['response'], match['fixture']['id'])
                else:
                    print('Partida sem dados para atualizar')
        else:
            print(f"Não há jogos Passados a serem atualizados")
        
    def update_date_matches(self, data):
        '''Atualiza as datas das partidas existentes no banco'''
        matches = self.api_data_manager.fetch_data(
            API_URL+f"fixtures?date={data}"
        )
        if not matches or 'response' not in matches:
            print("Nenhum dado de bets retornado pela API")
            return
        
        self.api_data_manager.update_matches(matches['response'])
        
    def update_matches_by_date(self, date, year = ''):
        '''
        Atualização das partidas realizadas da liga da temporada e na data
        '''
        url = f"fixtures?date={date}"
        if year != '':
            url += f"&season={year}"
        matches = self.api_data_manager.fetch_data(API_URL+url)
        if len(matches['response']) > 0:
            self.api_data_manager.update_matches(matches['response'])
            for match in matches['response']:
                match_statistic =  self.api_data_manager.fetch_data(API_URL+f"fixtures/statistics?fixture={match['fixture']['id']}")
                self.api_data_manager.save_statistics(match_statistic['response'], match['fixture']['id'])
        else:
            print(f"Não Jogos a serem atualizados no dia {date} da temporada {year}")

    def insert_matches(self,leagues, years):
        '''
        Inserção dos partidas na liga da temporada
        '''
        for league in leagues:
            for year in years:
                matches_data = self.api_data_manager.fetch_data(
                    API_URL+f"fixtures?league={league}&season={year}"
                )
                if not matches_data or 'response' not in matches_data:
                    print(f"Nenhum dado de partida retornado pela API para a liga {league} e temporada {year}")
                    return
                
                self.api_data_manager.save_matches(matches_data['response'], league)
          
    def update_halftime_goals(self, league, date, year):
        '''
        Atualização das partidas realizadas da liga da temporada e na data
        '''
        matches = self.api_data_manager.fetch_data(API_URL+f"fixtures?league={league}&season={year}")
        if len(matches['response']) > 0:
            self.api_data_manager.update_halftime_goals_matches(matches['response'])
        else:
            print(f"Não Jogos a serem atualizados no dia {date} da liga {league} da temporada {year}")

    def show_generics(self, url):
        data = self.api_data_manager.fetch_data(API_URL+url)
        print(data)
        
    def insert_bookmakers(self):
        '''
        Inserção dos bookmakers
        '''
        bookmakers = self.api_data_manager.fetch_data(
            API_URL+f"odds/bookmakers"
        )
        if not bookmakers or 'response' not in bookmakers:
            print("Nenhum dado de bookmakers retornado pela API")
            return
        self.api_data_manager.save_bookmakers(bookmakers['response'])
        
    def insert_bet_types(self):
        '''
        Inserção dos bookmakers
        '''
        bet_types = self.api_data_manager.fetch_data(
            API_URL+f"odds/bets"
        )
        if not bet_types or 'response' not in bet_types:
            print("Nenhum dado de bookmakers retornado pela API")
            return
        self.api_data_manager.save_bet_types(bet_types['response'])
        
    def insert_bets(self,league_id, season, date):
        '''
        Inserção dos bets/odds
        '''
        bets = self.api_data_manager.fetch_data(
            API_URL+f"odds?league={league_id}&season={season}&date={date}"
        )
        if not bets or 'response' not in bets:
            print("Nenhum dado de bets retornado pela API")
            return
        
        total_pages = bets['paging']['total']
        page = 1
        
        while page <= total_pages:
            print(f"Processando página {page}/{total_pages}")
            if page != 1:
                bets = self.api_data_manager.fetch_data(
                    API_URL + f"odds?league={league_id}&season={season}&date={date}&page={page}"
                )

            self.api_data_manager.save_bets(bets['response'])
            page += 1
    

        
        return leagues
    
    def insert_bets_by_date(self, date):
        '''
        Inserção dos bets/odds
        '''
        bets = self.api_data_manager.fetch_data(
            API_URL+f"odds?date={date}"
        )
        if not bets or 'response' not in bets:
            print("Nenhum dado de bets retornado pela API")
            return
        
        total_pages = bets['paging']['total']
        page = 1
        
        while page <= total_pages:
            print(f"Processando página {page}/{total_pages}")
            if page != 1:
                bets = self.api_data_manager.fetch_data(
                    API_URL + f"odds?date={date}&page={page}"
                )

            self.api_data_manager.save_bets_prediction(bets['response'])
            page += 1
    
    def insert_countries(self):
        '''
        Inserção de países
        '''
        countries_data = self.api_data_manager.fetch_data(
            API_URL+f"countries"
        )
        if not countries_data or 'response' not in countries_data:
            print("Nenhum dado de times retornado pela API")
            return

        self.api_data_manager.save_country(countries_data['response'], self.countries)

    
    def init_app_base(self):
        '''
        Inicialização do banco de dados
        '''
        print("Iniciando a inserção de dados")
        
        
        
        print("Inserindo países...")
        #self.insert_countries()

        print("Inserindo ligas...")
        leagues = self.insert_leagues()
        leagues_id = [item for sublista in leagues for item in sublista]
        #print("Inserindo Bookmakers e Bet Types...")
        #self.insert_bookmakers()
        #self.insert_bet_types()

        print("Inserindo Seasons...")
        for country in self.countries:
            for season in self.seasons:
                self.insert_season(season, country)

        
        
        
        print("Inserindo Jogos...")
        self.insert_teams_season(leagues_id, self.seasons)
        
        self.insert_matches(leagues_id, self.seasons)

        for league in leagues_id:
            matches = self.api_data_manager.get_match_without_statistics(league, 7500)
            print(f"Total de jogos a serem atualizados: {len(matches)} para a liga {league}")

            for match in matches:
                #print(f"Fetching statistic for match {match}")
                try:
                    self.insert_statistics(f"fixtures/statistics?fixture={match}", match)
                except Exception as e:
                    print(f"Error fetching statistics for match {match}: {e}")
                    continue
        
    def set_initials(self, countries, seasons):
        '''
        Inicialização de variaveis para começar o banco de dados
        '''
        self.countries = countries
        self.seasons = seasons

    def insert_statistics(self, url, match):
        '''
        Inserção das estatísticas
        '''
        statistics = self.api_data_manager.fetch_data(API_URL+url)
        if not statistics or 'response' not in statistics:
            print("Nenhum dado de statistics retornado pela API")
            return
        
        self.api_data_manager.save_statistics(statistics['response'], match)

if __name__ == "__main__":
    processor = DataProcessor()
    
    leagues = [league.id for league in processor.api_data_manager.get_leagues()]


    for league in leagues:
        print(f"Atualizando Partidas da Liga {league}")
        processor.update_all_pends_matches(league,repair=1)
