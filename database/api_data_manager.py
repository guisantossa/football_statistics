import requests
from .db import get_db, League, Team, Match, Player, Season, Country, SeasonTeam
from . import crud
from datetime import datetime
from dotenv import load_dotenv
import os
import traceback
import time


# Carregar variáveis do .env
load_dotenv()

RAPID_API_KEY = os.getenv('RAPID_API_KEY2')

class APIDataManager:

    def __init__(self):
        self.session = get_db()

    #busca de Dados por endpoints
    # url = endpoint desejado 
    def fetch_data(self, url):
        headers = {
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
            "X-RapidAPI-Key": RAPID_API_KEY
        }
        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()
            json_data = response.json()
            return json_data
        except requests.exceptions.HTTPError as http_err:
            print(f'HTTP error: {http_err}')
        except Exception as err:
            print(f'Error: {err}')
        return None

    def save_country(self, country_data):
        for country in country_data:
            print(f"Attempting to save country with name: {country['name']}")  # Debugging
            c = self.session.query(Country).filter(Country.code == country['code']).first()
            if country['code'] == None:
                country['code'] = 'N/A'
            if not c:
                print(f"Country {country['name']} not found, creating...")
                country = Country(
                    name=country['name'],
                    code=country['code']
                )
                self.session.add(country)
                self.session.commit()
            teams = self.fetch_data(f"https://api-football-v1.p.rapidapi.com/v3/teams?country={country['name']}")
            self.save_teams(teams['response'])
        return country
      
    def save_league(self, competition_data):
        for competition in competition_data:
            print(f"Attempting to save competition with ID: {competition['league']['name']}")
            first = self.session.query(League).filter(League.id == competition['league']['id']).first()
            if not first:
                print(f"Competição {competition['league']['name']} não encontrada, criando...")
                if competition['country']['code'] == None:
                    competition['country']['code'] = 'N/A'
                country_id = self.session.query(Country).filter(Country.code == competition['country']['code']).first()
                league = League(
                    id=competition['league']['id'],
                    name=competition['league']['name'],
                    type=competition['league']['type'],
                    logo=competition['league']['logo'],
                    country_id=country_id.id
                )
                self.session.add(league)
                self.session.commit()
                self.save_season(league.id, competition)
        return competition
        
    def save_season(self, competition_id, competition):
        for season in competition['seasons']:
            print(f"Attempting to save season with ID: {season['year']}")
            #first = self.session.query(LeagueSeason).filter(LeagueSeason.league_id == season['league']['id']).first()
            season = Season(
                league_id=competition_id,
                year=season['year'],
                current=season['current']
            )
            self.session.add(season)
            self.session.commit()

    
        headers = {
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
            "X-RapidAPI-Key": RAPID_API_KEY
        }
        try:
            response = requests.get("https://api-football-v1.p.rapidapi.com/v3/teams", headers=headers)
            response.raise_for_status()
            json_data = response.json()
            return json_data
        except requests.exceptions.HTTPError as http_err:
            print(f'HTTP error: {http_err}')
        except Exception as err:
            print(f'Error: {err}')
        return None
    
    def save_teams(self, team_data):
        
        print(f"Found {len(team_data)} teams")
        result = self.session.execute('SELECT 1').fetchall()
        print(result)
        for team in team_data:
            first = self.session.query(Team).filter(Team.id == team['team']['id']).first()
            if not first:
                print(f"Time {team['team']['name']} não encontrado, criando...")
                team = Team(id=team['team']['id'], name=team['team']['name'], short_name=team['team']['code'], city=team['team']['country'], img_url=team['team']['logo'])
                self.session.add(team)
                self.session.commit()
        time.sleep(10)
        return team
    
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

    def save_matches(self, matches_data):
        print(f"Found {len(matches_data)} matches")
        for match in matches_data:
            print(f"Attempting to save match with ID: {match['fixture']['id']}")
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
                    status=1 if match['fixture']['status']["long"] == "Match Finished" else 2 if match['fixture']['status']["long"] == "In Progress" else 0,
                    data=match['fixture']['date'],
                    matchday=match['league']['round'][-2:],
                    league_id=league.id  # Referência para o LeagueSeason
                )
                
                self.session.add(new_match)
                self.session.commit()
    
    def save_statistics(self, statistics, match_id):
        print(f"Atualizando as estatisticas do jogo: {match_id}")
        existing_match = self.session.query(Match).filter_by(id=match_id).first()
        if not existing_match:
            print(f"Partida {match_id} não encontrada")
            return
        else:
            existing_match.home_team_possession=statistics[0]['statistics'][9]['value'].replace('%', '')
            existing_match.away_team_possession=statistics[1]['statistics'][9]['value'].replace('%', '')
            existing_match.home_team_shots=statistics[0]['statistics'][2]['value']
            existing_match.away_team_shots=statistics[1]['statistics'][2]['value']
            existing_match.home_team_shots_on_target=statistics[0]['statistics'][0]['value']
            existing_match.away_team_shots_on_target=statistics[1]['statistics'][0]['value']
            existing_match.home_team_fouls=statistics[0]['statistics'][6]['value']
            existing_match.away_team_fouls=statistics[1]['statistics'][6]['value']
            existing_match.home_team_corners=statistics[0]['statistics'][7]['value']
            existing_match.away_team_corners=statistics[1]['statistics'][7]['value']
            existing_match.home_team_yellow_cards=statistics[0]['statistics'][10]['value']
            existing_match.away_team_yellow_cards=statistics[1]['statistics'][10]['value']
            existing_match.home_team_red_cards=statistics[0]['statistics'][11]['value']
            existing_match.away_team_red_cards=statistics[1]['statistics'][11]['value']
            
           
            self.session.commit()

    #uma função simplesmente para pegar os ids das partidas e adicionar as estatisticas por parte, para não estourar o limite diário de consultas
    def get_match_without_statistics(self, league_id, limit=100):
        league = self.session.query(League).filter(
            League.id == league_id
        ).first()
        if not league:
            print(f"Nenhuma LeagueSeason encontrada para league_id={league_id}")
            return []

        matches = self.session.query(Match).filter(
            Match.league_id == league.id,
            Match.status == '1',
            Match.home_team_possession == None
        ).all()
        match_ids = [match.id for match in matches][:limit]

        return match_ids

    def update_matches(self, matches_data):
        '''
            Função para UPDATE de partidas realizadas no dia
        '''
        print(f"Found {len(matches_data)} matches")
        
        # Instanciando o CRUD de matches
        match_crud = crud.CRUDMatch(Match)
        for match in matches_data:
            try:
                existing_match = self.session.query(Match).filter(Match.id == match['fixture']['id']).first()
                if existing_match:
                    print(f"Atualizando partida {match['fixture']['id']}")
                    update_data = {
                        'status': 1 if match['fixture']['status']["long"] == "Match Finished" else 2 if match['fixture']['status']["long"] == "In Progress" else 0,
                        'home_team_goals': match['goals']['home'],
                        'away_team_goals': match['goals']['away']
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
    
    def insert_teams_season(self, season_data, league_id, season_year, is_current):
        """
        Insere os times de uma liga específica para uma temporada
        
        Args:
            league_id (int): ID da liga (ex: 39 para Premier League)
            season_year (str): Ano da temporada (ex: "2023-2024")
        """
        try:
            #verifica se a temporada existe
            season = self.session.query(Season).filter(
                Season.league_id == league_id,
                Season.year == season_year
            ).first()
            
            if not season:
                season = self.add_season(39, "2024", is_current)
            print(season.id)
            # 3. Processa cada time
            for team_info in season_data:
                team_data = team_info['team']
                
                # Verifica se o time já existe no banco
                team = self.session.query(Team).filter(Team.id == team_data['id']).first()
                
                if not team:
                    # Cria o time se não existir
                    team = Team(
                        id=team_data['id'],
                        name=team_data['name'],
                        short_name=team_data['code'],
                        city=team_data.get('country', 'Unknown'),
                        img_url=team_data['logo']
                    )
                    self.session.add(team)
                    self.session.commit()
                    print(f"Time {team_data['name']} criado com ID {team_data['id']}")
                    
                # 4. Associa o time à temporada
                existing_association = self.session.query(SeasonTeam).filter(
                    SeasonTeam.season_id == season.id,
                    SeasonTeam.team_id == team.id
                ).first()
                
                if not existing_association:
                    new_association = SeasonTeam(
                        season_id=season.id,
                        team_id=team.id
                    )
                    self.session.add(new_association)
                    print(f"Time {team.name} associado à temporada {season_year}")
                
            self.session.commit()
            print("Associação de times à temporada concluída com sucesso!")
        except Exception as e:
            self.session.rollback()
            print(f"Erro ao inserir times na temporada: {str(e)}")
            traceback.print_exc()
        finally:
            self.close()
    
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
            
            
    def close(self):
        self.session.close()
