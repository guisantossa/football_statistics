from dotenv import load_dotenv
import os
import sys
from pathlib import Path

# Import relativo (se o arquivo estiver em src/app/core)
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from database.data_processor import DataProcessor

def main():
    processor = DataProcessor()
    print('Inserindo Times')
    processor.insert_teams_country('Italy')
    leagues = ['135']
    seasons = ['2024']
    print('inserindo jogos')
    processor.insert_matches(leagues, seasons)
    #processor.insert_leagues()
    #processor.insert_season('2024')
    
    

    

if __name__ == '__main__':
    main()