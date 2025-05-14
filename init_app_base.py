
from database.data_processor import DataProcessor
import time

def main():
    
   
    season = [2024,2025]
    countries = ['Brazil','Argentina','Spain','Italy','Germany','France','Portugal','England', 'Netherlands']
    countries = ['Turkey', 'Saudi-Arabia', 'USA', 'Russia']
    countries = ['Argentina','Mexico', 'Chile']
                 #'Belgium','Turkey','Russia','Ukraine','Scotland','Greece','Switzerland','Denmark','Norway','Sweden','Saudi Arabia', 'Mexico', 'USA',
                 #'Switzerland','Austria','Czech Republic','Poland','Romania','Hungary','Serbia','Croatia','Bulgaria']
    
    
    processor = DataProcessor()
    processor.set_initials(countries, season)
    
    processor.init_app_base()

   
        
    
    #processor.insert_bookmakers()
    #processor.insert_bets(39,2024,'2025-04-19')
    




if __name__ == '__main__':
    main()