from api_data_manager import APIDataManager
from data_processor import DataProcessor
import time

def main():
    
    url = "https://api-football-v1.p.rapidapi.com/v3/"
    processor = APIDataManager()
    #processor = DataProcessor()
    #processor.insert_leagues()
    #processor.insert_season(2024)
    #processor.insert_season(2025)
    '''
    countries = ['Netherlands']
    for country in countries:
        print(f"Fetching data for {country}")
        teams = processor.fetch_data(url+f"teams?country={country}")
        processor.save_teams(teams['response'])
    '''
    '''
    leagues = [39]
    years = ['2023','2022','2021']
    for league in leagues:
        for year in years:
            print(f"Fetching matches for {league} season {year}")
            matches = processor.fetch_data(url+f"fixtures?league={league}&season={year}")
            processor.save_matches(matches['response'])
    
    '''
    
    matches = processor.get_match_without_statistics(203,100)

    print("Fetching matches statistic...")
    for match in matches:
        print(f"Fetching statistic for match {match}")
        try:
            match_statistic =  processor.fetch_data(url+f"fixtures/statistics?fixture={match}")
            processor.save_statistics(match_statistic['response'], match)
        except Exception as e:
            print(f"Error fetching statistics for match {match}: {e}")
            continue
        
        time.sleep(2)
        
    
    processor.insert_bets(39,2024,'2025-04-19')
    




if __name__ == '__main__':
    main()