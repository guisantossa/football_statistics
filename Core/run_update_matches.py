from dotenv import load_dotenv
import os
import sys
from pathlib import Path

# Import relativo (se o arquivo estiver em src/app/core)
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from database.data_processor import DataProcessor

def main():
    processor = DataProcessor()
    processor.update_matches('39','2025-04-02','2024')
    #processor.insert_teams_season('39','2024',True)

    

if __name__ == '__main__':
    main()




