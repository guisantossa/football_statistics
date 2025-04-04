from api_data_manager import APIDataManager
import time

def main():
    
    url = "https://api-football-v1.p.rapidapi.com/v3/"
    processor = APIDataManager()
    countries = ["Brazil"]
    #for country in countries:
    #    print(f"Fetching data for {country}")
    #    teams = processor.fetch_data(url+f"teams?country={country}")
    #    processor.save_teams(teams['response'])
    #leagues = ["Bundesliga", "Serie A", "Ligue 1", "La Liga", "Premier League", "Primeira Liga", "Eredivisie", "Süper Lig"]
    leagues = [71]
    years = ['2024','2025']
    #for league in leagues:
    #    for year in years:
    #        print(f"Fetching matches for {league} season {year}")
    #        matches = processor.fetch_data(url+f"fixtures?league={league}&season={year}")
    #        processor.save_matches(matches['response'])
    #processor.fetch_data(url+f"teams?coountry={country['name']}")
    #print("Fetching countries...")
    #countries = processor.fetch_countries()
    #countries = processor.save_country(countries['response'])
    matches = processor.get_match_without_statistics(71)

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




if __name__ == '__main__':
    main()