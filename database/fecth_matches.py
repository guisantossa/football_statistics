import requests
import json


#chave API, para acessar a API da football-data.org colocar no .env

#url da API
API_URL = "https://api.football-data.org/v4/competitions/PL/matches"

#headers para acessar a API
headers = {
    'X-Auth-Token': API_KEY
}

def fetch_matches():
    try:
        response = requests.get(API_URL, headers=headers)
        data = response.raise_for_status() #levanta um erro se a resposta não for 200
        return response.json() #Retorna o erro em formato Json
    except requests.exceptions.HTTPError as http_err:
        print(f'HTTP error: {http_err}')
    except  Exception as err:
        print(f'Error: {err}')
    return None

#função para salvar os dados em um arquivo json
def save_matches_data_file(data):
    with open('data/matches.json', 'w') as file:
        json.dump(data, file, indent=4)
        print("Dados salvos com sucesso!")

#pegar os dados dos jogos
match_data = fetch_matches()

if match_data:
    save_matches_data_file(match_data)
