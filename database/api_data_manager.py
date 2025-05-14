import requests
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from database.db import get_db, League, Team, Match, Player, Season, Country, Season, Bookmaker, BetType, Bet
from sqlalchemy import or_, and_
from database.crud import CRUDBase, CRUDMatch
from datetime import datetime
from dotenv import load_dotenv
import os
import pandas as pd
import traceback
import time
import logging


# Carregar variáveis do .env
load_dotenv()

RAPID_API_KEY = os.getenv('RAPID_API_KEY')

class APIDataManager:

    def __init__(self):
        self.session = get_db()
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)
        
        handler = logging.StreamHandler()
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)

    #busca de Dados por endpoints
    # url = endpoint desejado 
    def fetch_data(self, url, max_retries=3):
        headers = {
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
            "X-RapidAPI-Key": RAPID_API_KEY
        }
        for attempt in range(max_retries):
            try:
                response = requests.get(url, headers=headers, timeout=10)
                response.raise_for_status()
                data = response.json()
                if not data or 'response' not in data:
                    print(f"Nenhum dado válido retornado para {url}")
                    return None
                return data
            except requests.exceptions.HTTPError as http_err:
                if response.status_code == 429:  # Too Many Requests
                    wait_time = int(response.headers.get('Retry-After', 30))
                    print(f"Rate limited. Waiting {wait_time} seconds...")
                    time.sleep(wait_time)
                    continue
                print(f'HTTP error {response.status_code}: {http_err}')
            except Exception as err:
                print(f'Attempt {attempt + 1} failed: {err}')
                if attempt < max_retries - 1:
                    time.sleep(2 ** attempt)  # Exponential backoff
        return None

    def save_country(self, country_data, countries_selected = None):
        for country in country_data:
            if countries_selected and country['name'] not in countries_selected:
                print(f"Country {country['name']} not in selected countries, skipping...")
                continue
            print(f"Attempting to save country with name: {country['name']}")  # Debugging
            c = self.session.query(Country).filter(Country.code == country['code']).first()
            if country['code'] == None:
                country['code'] = 'N/A'
            if not c:
                print(f"Country {country['name']} not found, creating...")
                country_add = Country(
                    name=country['name'],
                    code=country['code']
                )
                self.session.add(country_add)
                self.session.commit()
                teams = self.fetch_data(f"https://api-football-v1.p.rapidapi.com/v3/teams?country={country['name']}")
                self.save_teams(teams['response'])
 
    def save_league(self, competition_data):
        leagues_id = []
        leagues_ignored = ['236']
        
        for competition in competition_data:
            if competition['league']['id'] in leagues_ignored:
                print(f"Competition {competition['league']['name']} is ignored, skipping...")
                continue
            if competition['league']['type'] != 'League':
                print(f"Competition {competition['league']['name']} is not a league, skipping...")
                continue

            print(f"Attempting to save competition with ID: {competition['league']['name']}")
            first = self.session.query(League).filter(League.id == competition['league']['id']).first()
            if(competition['seasons'][0]['coverage']['fixtures']["statistics_fixtures"] == False):
                print('Competição não habilitada')
                continue
            else:
                if not first:
                    print(f"Competição {competition['league']['name']} não encontrada, criando...")
                    if competition['country']['code'] == None:
                        competition['country']['code'] = 'N/A'
                    country_id = self.session.query(Country).filter(Country.code == competition['country']['code']).first()
                    if not country_id:
                        print(f"Country {competition['country']['name']} not found (não habilitado), creating...")
                        continue

                    league = League(
                        id=competition['league']['id'],
                        name=competition['league']['name'],
                        type=competition['league']['type'],
                        logo=competition['league']['logo'],
                        country_id=country_id.id
                    )
                    self.session.add(league)
                    self.session.commit()
                    
                else:
                    print(f"Competição {competition['league']['name']} já existe")
                
                leagues_id.append(competition['league']['id'])
                    
        return leagues_id

    def get_leagues(self, country_id = None):
        leagues = self.session.query(League).filter(League.type == 'League').all()
        return leagues
    
    def get_countries(self):
        countries = self.session.query(Country).all()
        return countries
    
    def save_season(self, seasons_data, countries_selected = None):
        for season_data in seasons_data:
            if countries_selected and season_data['country']['name'] not in countries_selected:
                print(f"Country {season_data['country']['name']} not in selected countries, skipping...")
                continue
            try:
                # Verifica se a temporada já existe
                existing_season = self.session.query(Season).filter(
                    Season.league_id == season_data['league']['id'],
                    Season.year == str(season_data['seasons'][0]['year'])
                ).first()
                
                if existing_season:
                    print(f"Season {season_data['seasons'][0]['year']} from {season_data['league']['name']} from country {season_data['country']['name']} already exists")
                    continue
                if(season_data['seasons'][0]['coverage']['fixtures']["statistics_fixtures"] == False):
                    print('Temporada não habilitada')
                    continue
                else:
                    # Verifica se a temporada já existe
                    existing_league = self.session.query(League).filter(
                        League.id == season_data['league']['id']
                        ).first()
                    if not existing_league:
                        print(f"League {season_data['league']['name']} não encontrada. Cadastrando...")
                        self.save_league([season_data])
                    print(f"Saving season {season_data['seasons'][0]['year']} from {season_data['league']['name']} from country {season_data['country']['name']}")
                    # Cria nova temporada
                    new_season = Season(
                        league_id=season_data['league']['id'],
                        year=season_data['seasons'][0]['year'],
                        current=season_data['seasons'][0]['current'],
                        type=season_data['league']['type'],
                        logo='in Leagues',
                        start_date=season_data['seasons'][0]['start'],
                        end_date=season_data['seasons'][0]['end']
                    )
                    
                    self.session.add(new_season)
                    self.session.commit()
                
            except KeyError as e:
                print(f"Error: Missing key in season data - {e}")
                self.session.rollback()
                continue
                
            except ValueError as e:
                print(f"Error: Invalid date values - {e}")
                self.session.rollback()
                continue
                
            except Exception as e:
                print(f"Unexpected error saving season: {e}")
                self.session.rollback()
                continue
            
    def save_teams(self, team_data):
        
        print(f"Found {len(team_data)} teams")
        for team in team_data:
            first = self.session.query(Team).filter(Team.id == team['team']['id']).first()
            if not first:
                print(f"Time {team['team']['name']} não encontrado, criando...")
                team = Team(id=team['team']['id'], name=team['team']['name'], short_name=team['team']['code'], city=team['team']['country'], img_url=team['team']['logo'])
                self.session.add(team)
                self.session.commit()
 
    
    def save_match(self, match_data, competition_id, home_team_id, away_team_id):
        existing_match = self.session.query(Match).filter(Match.id == match_data['id']).first()
        if existing_match:
            print(f"Match {match_data['id']} already exists in the database")
            return existing_match

        match = Match(
            id=match_data['id'],
            league_id=competition_id,
            home_team_id=home_team_id,
            away_team_id=away_team_id,
            matchday=match_data.get('matchday'),
            utc_date=datetime.strptime(match_data['date'], "%Y-%m-%dT%H:%M:%SZ"),
            status=match_data['status'],
            home_team_score=match_data['score']['home'],
            away_team_score=match_data['score']['away']
        )
        self.session.add(match)
        self.session.commit()
        return match

    def save_player_stats(self, match_id, player_data, team_id):
        player = self.session.query(Player).filter(Player.id == player_data['id']).first()
        if not player:
            print(f"Player {player_data['id']} não encontrado, criando...")
            player = Player(
                id=player_data['id'],
                first_name=player_data['first_name'],
                last_name=player_data['last_name'],
                nationality=player_data.get('nationality'),
                position=player_data.get('position'),
                date_of_birth=player_data.get('date_of_birth'),
                team_id=team_id
            )
            self.session.add(player)
            self.session.commit()

        player_stat = PlayerStats(
            match_id=match_id,
            player_id=player.id,
            minutes_played=player_data['statistics']['minutesPlayed'],
            goals=player_data['statistics']['goals'],
            assists=player_data['statistics']['assists'],
            yellow_cards=player_data['statistics']['yellowCards'],
            red_cards=player_data['statistics']['redCards'],
            shots=player_data['statistics']['shots'],
            shots_on_target=player_data['statistics']['shotsOnTarget'],
            fouls=player_data['statistics']['fouls']
        )
        self.session.add(player_stat)
        self.session.commit()

    def save_matches(self, matches_data, league_id):
        print(f"Found {len(matches_data)} matches - League {league_id}")
        for match in matches_data:
            league = self.session.query(League).filter(
                League.id == match['league']['id']
            ).first()
            if not league:
                continue
           
            # Agora, verificamos se a partida já existe no banco
            existing_match = self.session.query(Match).filter(Match.id == match['fixture']['id']).first()
            if not existing_match:
                print(f"Partida {match['fixture']['id']} não encontrada, criando...")
                
                # Salvando os times
                home_team = self.session.query(Team).filter(Team.id == match['teams']['home']['id']).first()
                away_team = self.session.query(Team).filter(Team.id == match['teams']['away']['id']).first()
                if not home_team:
                    print(f"Time da casa {match['teams']['home']['name']} não encontrado")
                    # Lidar com isso depois
                    continue

                if not away_team:
                    print(f"Time visitante {match['teams']['home']['name']} não encontrado")
                    #lidar com isso depois
                    continue

                # Criando a partida
                #Criar futuramente gols no meio periodo
                new_match = Match(
                    id=match['fixture']['id'],
                    home_team_id=home_team.id,
                    away_team_id=away_team.id,
                    home_team_goals=match['goals']['home'],
                    away_team_goals=match['goals']['away'],
                    home_team_goals_firsthalf=match['score']['halftime']['home'],
                    away_team_goals_firsthalf=match['score']['halftime']['away'],
                    status=1 if match['fixture']['status']["long"] == "Match Finished" else 2 if match['fixture']['status']["long"] == "In Progress" else 0,
                    data=match['fixture']['date'],
                    matchday=self.get_match_day(match['league']['round']),
                    league_id=league.id  # Referência para o LeagueSeason
                )
                
                self.session.add(new_match)
                self.session.commit()
            
                
    def get_match_day(self, matchday):
        if 'Quarter-finals' in matchday:
            return 'Quarter-finals'
        elif  'Semi-finals' in matchday:
            return 'Semi-finals'
        elif 'Final' in matchday:
            return 'Final'
        elif '3rd Place Final' in matchday: 
            return '3rd Place Final'
        elif 'Relegation Round' in matchday:
            return 'Relegation Round'
        elif 'Preliminary Round' in matchday:
            return 'Preliminary Round'
        else:
            return matchday
    
    
    def save_statistics(self, statistics, match_id):
        print(f"Atualizando as estatisticas do jogo: {match_id}")
        existing_match = self.session.query(Match).filter_by(id=match_id).first()
        
        def get_stat_value(stat_list, team_idx, stat_idx, default='0', is_percentage=False):
            try:
                value = stat_list[team_idx]['statistics'][stat_idx]['value']
                if value is None:
                    return default
                if is_percentage and value is not None:
                    return value.replace('%', '')
                return value
            except (IndexError, KeyError, TypeError):
                return default
                
        if not existing_match:
            print(f"Partida {match_id} não encontrada")
            return
        else:
            existing_match.home_team_possession=get_stat_value(statistics, 0, 9, is_percentage=True)
            existing_match.away_team_possession=get_stat_value(statistics, 1, 9, is_percentage=True)
            existing_match.home_team_shots = get_stat_value(statistics, 0, 2)
            existing_match.away_team_shots = get_stat_value(statistics, 1, 2)
            existing_match.home_team_shots_on_target = get_stat_value(statistics, 0, 0)
            existing_match.away_team_shots_on_target = get_stat_value(statistics, 1, 0)
            existing_match.home_team_fouls = get_stat_value(statistics, 0, 6)
            existing_match.away_team_fouls = get_stat_value(statistics, 1, 6)
            existing_match.home_team_corners = get_stat_value(statistics, 0, 7)
            existing_match.away_team_corners = get_stat_value(statistics, 1, 7)
            existing_match.home_team_yellow_cards = get_stat_value(statistics, 0, 10)
            existing_match.away_team_yellow_cards = get_stat_value(statistics, 1, 10)
            existing_match.home_team_red_cards = get_stat_value(statistics, 0, 11)
            existing_match.away_team_red_cards = get_stat_value(statistics, 1, 11)
            
           
            self.session.commit()
            

    def get_matches_to_update(self, league_id:int = None):
        '''
        Procura as partidas a serem atualizadas
        '''
        if league_id:
            league = self.session.query(League).filter(
                League.id == league_id
            ).first()
            if not league:
                print(f"Nenhuma League encontrada para league_id={league_id}")
                return []
            matches = self.session.query(Match).filter(
                    (Match.status == '0'), Match.data < datetime.now(), Match.league_id == league_id)
        else:
            matches = self.session.query(Match).filter(Match.status == '0', Match.data < datetime.now())
        
        # Extrai os IDs e converte para string
        ids = [str(match.id) for match in matches]
        print(f"{len(ids)} partidas encontradas")
        # Junta os IDs com "-"
        ids = "-".join(ids)
        return ids
    
    def repair_matches_to_update(self, league_id:int = None):
        '''
        Procura as partidas a serem atualizadas
        '''
        if league_id:
            league = self.session.query(League).filter(
                League.id == league_id
            ).first()
            if not league:
                print(f"Nenhuma League encontrada para league_id={league_id}")
                return []
            matches = self.session.query(Match).filter(
                    Match.status == '1', Match.data < datetime.now(), Match.league_id == league_id, Match.home_team_possession.is_(None) )
        else:
            matches = self.session.query(Match).filter(Match.status == '0', Match.data < datetime.now())
        
        # Extrai os IDs e converte para string
        ids = [str(match.id) for match in matches]
        print(f"{len(ids)} partidas encontradas")
        # Junta os IDs com "-"
        ids = "-".join(ids)
        return ids

    def save_bet_types(self, bet_types_data):
        for bet_type in bet_types_data:
            try:
                # Verifica se a temporada já existe
                existing_bet_types = self.session.query(BetType).filter(
                    BetType.id == bet_type['id']
                ).first()
                
                if existing_bet_types:
                    print(f"Bet Type {existing_bet_types['name']} already exists")
                    continue

                print(f"Saving Bet Type {bet_type['name']} ")
                
                # Cria nova temporada
                new_bet_type = BetType(
                    id=bet_type['id'],
                    name=bet_type['name']
                )
                
                self.session.add(new_bet_type)
                self.session.commit()
                
            except KeyError as e:
                print(f"Error: Missing key in bet type data - {e}")
                self.session.rollback()
                continue
                
            except ValueError as e:
                print(f"Error: Invalid date values - {e}")
                self.session.rollback()
                continue
                
            except Exception as e:
                print(f"Unexpected error saving bet type: {e}")
                self.session.rollback()
                continue
    
    def save_bookmakers(self, bookmakers_data):
        for bookmaker in bookmakers_data:
            try:
                # Verifica se a temporada já existe
                existing_bookmaker = self.session.query(Bookmaker).filter(
                    Bookmaker.id == bookmaker['id']
                ).first()
                
                if existing_bookmaker:
                    print(f"Bookmaker {existing_bookmaker['name']} already exists")
                    continue

                print(f"Saving Bookmaker {bookmaker['name']} ")
                
                # Cria nova temporada
                new_bookmaker = Bookmaker(
                    id=bookmaker['id'],
                    name=bookmaker['name']
                    
                )
                
                self.session.add(new_bookmaker)
                self.session.commit()
                
            except KeyError as e:
                print(f"Error: Missing key in bookmaker data - {e}")
                self.session.rollback()
                continue
                
            except ValueError as e:
                print(f"Error: Invalid date values - {e}")
                self.session.rollback()
                continue
                
            except Exception as e:
                print(f"Unexpected error saving bookmaker: {e}")
                self.session.rollback()
                continue
    
    def save_bets(self, bets_data):
        for bets in bets_data:
            for bets_bookmakers in bets['bookmakers']:
                for bet_type in bets_bookmakers['bets']:
                    for bet in bet_type['values']:
                        try:
                            # Verifica se a temporada já existe
                            bet_existing = self.session.query(Bet).filter(
                                Bet.match_id == bets['fixture']['id'],
                                Bet.bet_type_id == bet_type['id'],
                                Bet.bookmaker_id == bets_bookmakers['id'],
                                Bet.bet_value == str(bet['value'])
                            ).first()
                            
                            if bet_existing:
                                print(f"Bet já existe {bet['value']} already exists")
                                continue

                            print(f"Saving Bet para a partida {bets['fixture']['id']} {bet_type['id']} valor {bet['value']} ")
                            
                            # Cria nova temporada
                            new_bet = Bet(
                                match_id=bets['fixture']['id'],
                                bet_type_id=bet_type['id'],
                                bookmaker_id=bets_bookmakers['id'],
                                bet_value=bet['value'],
                                odd=bet['odd']
                            )
                            
                            self.session.add(new_bet)
                            self.session.commit()
                            
                        except KeyError as e:
                            print(f"Error: Missing key in bet data - {e}")
                            self.session.rollback()
                            continue
                            
                        except ValueError as e:
                            print(f"Error: Invalid date values - {e}")
                            self.session.rollback()
                            continue
                            
                        except Exception as e:
                            print(f"Unexpected error saving bet: {e}")
                            self.session.rollback()
                            continue
    
    def save_bets_prediction(self, bets_data):
        '''
        Salva as Odds das previsões de apostas 
        '''
        bet_types_insert = [5, 45, 80, 6, 16, 17]
        for bets in bets_data:
            #verifica se tem a fixture
            fixture = self.session.query(Match).filter(
                Match.id == bets['fixture']['id']
            ).first()

            if not fixture:
                #print(f"Fixture {bets['fixture']['id']} não encontrada")
                continue
            for bets_bookmakers in bets['bookmakers']:
                if bets_bookmakers['name'] != 'Betano':
                    print(f"Bookmaker {bets_bookmakers['name']} não é Betano, pulando...")
                    continue
                for bet_type in bets_bookmakers['bets']:
                    for bet in bet_type['values']:
                        if bet_type['id'] not in bet_types_insert:
                            print(f"Bet Type {bet_type['id']} não é uma aposta com previsão, pulando... {bets['fixture']['id']}")
                            continue
                        try:
                            # Verifica se a bet já existe
                            bet_existing = self.session.query(Bet).filter(
                                Bet.match_id == bets['fixture']['id'],
                                Bet.bet_type_id == bet_type['id'],
                                Bet.bookmaker_id == bets_bookmakers['id'],
                                Bet.bet_value == str(bet['value'])
                            ).first()
                            
                            if bet_existing:
                                print(f"Bet já existe {bet['value']} already exists")
                                continue
                            print(f"Saving Bet para a partida {bets['fixture']['id']} {bet_type['id']} valor {bet['value']} ")
                            
                            # Cria nova temporada
                            new_bet = Bet(
                                match_id=bets['fixture']['id'],
                                bet_type_id=bet_type['id'],
                                bookmaker_id=bets_bookmakers['id'],
                                bet_value=bet['value'],
                                odd=bet['odd']
                            )
                            
                            self.session.add(new_bet)
                            self.session.commit()
                            
                        except KeyError as e:
                            print(f"Error: Missing key in bet data - {e}")
                            self.session.rollback()
                            continue
                            
                        except ValueError as e:
                            print(f"Error: Invalid date values - {e}")
                            self.session.rollback()
                            continue
                            
                        except Exception as e:
                            print(f"Unexpected error saving bet: {e}")
                            self.session.rollback()
                            continue
    
    def get_match_without_statistics(self, league_id, limit=100):
        '''
        uma função simplesmente para pegar os ids das partidas e adicionar as estatisticas por parte, para não estourar o limite diário de consultas
        '''

        matches = self.session.query(Match).filter(
            Match.league_id == league_id,
            Match.status == '1',
            Match.home_team_possession == None
        ).all()
        if limit is None:
            match_ids = [match.id for match in matches]
        else:
            match_ids = [match.id for match in matches][:limit]

        return match_ids

    def update_matches(self, matches_data):
        '''
            Função para UPDATE de partidas realizadas no dia
        '''
        print(f"Found {len(matches_data)} matches")
        
        # Instanciando o CRUD de matches
        match_crud = CRUDMatch(Match)
        for match in matches_data:
            try:
                existing_match = self.session.query(Match).filter(Match.id == match['fixture']['id']).first()
                if existing_match:
                    print(f"Atualizando partida {match['fixture']['id']}")
                    update_data = {
                        'status': 1 if match['fixture']['status']["long"] == "Match Finished" else 2 if match['fixture']['status']["long"] == "In Progress" else 0,
                        'home_team_goals': match['goals']['home'],
                        'away_team_goals': match['goals']['away'],
                        'home_team_goals_firsthalf':match['score']['halftime']['home'],
                        'away_team_goals_firsthalf':match['score']['halftime']['away'],
                        'data': match['fixture']['date']
                    }
                    match_crud.update(
                        db=self.session,
                        db_obj=existing_match,
                        obj_in=update_data
                    )
                    #print(f"Partida {match['fixture']['id']} atualizada com sucesso")
                #else:
                    #print(f"Partida {match['fixture']['id']} não encontrada no banco de dados")
                    
            except Exception as e:
                print(f"Erro ao atualizar partida {match['fixture']['id']}: {str(e)}")
                traceback.print_exc()
                self.session.rollback()
    
    def add_season(self, league_id, season_year, is_current=True):
        """
        Adiciona uma nova temporada se ela não existir
        
        Args:
            league_id (int): ID da liga
            season_year (str): Ano/identificador da temporada (ex: "2024")
            is_current (bool): Se é a temporada atual
        """       
        try:
            # Verifica se a temporada já existe
            existing_season = self.session.query(Season).filter(
                Season.league_id == league_id,
                Season.year == season_year
            ).first()
            
            if not existing_season:
                # Busca informações adicionais da API se necessário
                league_data = self.fetch_data(
                    f"https://api-football-v1.p.rapidapi.com/v3/leagues?id={league_id}"
                )
                    # Cria a nova temporada
                new_season = Season(
                    league_id=league_id,
                    year=season_year,
                    current=is_current
                    #start_date=league_data.get('response', [{}])[0].get('seasons', [{}])[0].get('start', None),
                    #end_date=league_data.get('response', [{}])[0].get('seasons', [{}])[0].get('end', None)
                )
                
                self.session.add(new_season)
                self.session.commit()
                print(f"Temporada {season_year} criada com sucesso para liga {league_id}")
                return new_season
            else:
                print(f"Temporada {season_year} já existe para liga {league_id}")
                return existing_season
            
        except Exception as e:
            self.session.rollback()
            print(f"Erro ao criar temporada: {str(e)}")
            traceback.print_exc()
            return None
        finally:
            self.close()
    
    def export_to_file(self, endpoint: str, file_prefix: str = "data", save_csv: bool = False):
        """
            Extrai dados da API e salva em arquivo (Parquet + opcionalmente CSV).
            
            Uso:
                export_to_file("fixtures", {"league": 71, "season": 2023}, "partidas")
        """
        try:
            data = self.fetch_data(f"https://api-football-v1.p.rapidapi.com/v3/{endpoint}")
            # 2. Transforma para DataFrame
            df = pd.json_normalize(data['response'], sep='_')
            df['extracted_at'] = datetime.now()  # Adiciona timestamp
            
            # 3. Define caminho do arquivo
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_dir = "data/exports"
            os.makedirs(output_dir, exist_ok=True)
            base_path = f"{output_dir}/{file_prefix}_{timestamp}"
            
            # 4. Salva Parquet (obrigatório)
            df.to_parquet(f"{base_path}.parquet", engine='pyarrow')
            print(f"✅ Dados salvos em {base_path}.parquet")
            
            # 5. Opcional: Salva CSV (para inspeção rápida)
            if save_csv:
                df.to_csv(f"{base_path}.csv", index=False)
                print(f"✅ Versão CSV salva em {base_path}.csv")

            return base_path
        except Exception as e:
            print(f"❌ Erro ao exportar {endpoint}: {str(e)}")
        return None
    
    def update_halftime_goals_matches(self, matches_data):
        '''
            Função para UPDATE de gols no meio do jogo (implementação, usada apenas 1 vez)
        '''
        print(f"Found {len(matches_data)} matches")
        
        # Instanciando o CRUD de matches
        match_crud = CRUDMatch(Match)
        for match in matches_data:
            try:
                existing_match = self.session.query(Match).filter(Match.id == match['fixture']['id']).first()
                if existing_match:
                    print(f"Atualizando partida {match['fixture']['id']}")
                    update_data = {
                        'home_team_goals_firsthalf':match['score']['halftime']['home'],
                        'away_team_goals_firsthalf':match['score']['halftime']['away'],
                    }
                    match_crud.update(
                        db=self.session,
                        db_obj=existing_match,
                        obj_in=update_data
                    )
                    print(f"Partida {match['fixture']['id']} atualizada com sucesso")
                else:
                    print(f"Partida {match['fixture']['id']} não encontrada no banco de dados")
                    
            except Exception as e:
                print(f"Erro ao atualizar partida {match['fixture']['id']}: {str(e)}")
                traceback.print_exc()
                self.session.rollback()
           
    def close(self):
        self.session.close()
