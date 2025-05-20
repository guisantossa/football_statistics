from pyspark.sql import functions as F

from typing import List, Dict
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))  # Volta até app
from Core.spark_manager import SparkManager


class DashboardAnalytics(SparkManager):
    def __init__(self, app_name="FootballAnalytics"):
        super().__init__(app_name)
        
    def get_bets_results_per_combinations(self, data):
        self.read_from_db()
        pass
    
    def get_bet_results_per_odds_line(self, data):
        df = self.read_from_db('odds_classification_results').filter((F.col('created_at') == data))
        return [row.asDict() for row in df.collect()]

    
    def get_bet_results_per_bet_type(self):
        pass
    
    