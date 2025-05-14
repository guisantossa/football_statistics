feature_config = {
        'goals': { 
            'features' : [
                "home_team_goals", "away_team_goals",
                "home_team_shots", "away_team_shots",
                "home_team_goals_pro", "away_team_goals_pro",
                "home_team_goals_against", "away_team_goals_against",
                "home_team_rank", "away_team_rank"
            ],
            'home_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_shots").alias("home_team_shots"),
                F.avg("away_team_shots").alias("away_team_shots"),
                F.avg("home_team_goals_pro").alias("home_team_goals_pro"),
                F.avg("home_team_goals_against").alias("home_team_goals_against"),
                F.avg("home_team_rank").alias("home_team_rank")
            ],
            'away_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_shots").alias("home_team_shots"),
                F.avg("away_team_shots").alias("away_team_shots"),
                F.avg("away_team_goals_pro").alias("away_team_goals_pro"),
                F.avg("away_team_goals_against").alias("away_team_goals_against"),
                F.avg("away_team_rank").alias("away_team_rank")
            ],
            'label': 'goals_total',
            'label_expr': F.col("home_team_goals") + F.col("away_team_goals"),
            'value_init': 0.5
            
        },
        'corners': { 
            'features': [ 
                "home_team_shots", "away_team_shots",
                "home_team_goals", "away_team_goals",
                "home_team_rank", "away_team_rank",
                "home_team_corners", "away_team_corners",
                "home_team_possession", "away_team_possession"
            ],
            'home_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_shots").alias("home_team_shots"),
                F.avg("away_team_shots").alias("away_team_shots"),
                F.avg("home_team_corners").alias("home_team_corners"),
                F.avg("away_team_corners").alias("away_team_corners"),
                F.avg("home_team_possession").alias("home_team_possession"),
                F.avg("away_team_possession").alias("away_team_possession"),
                F.avg("home_team_rank").alias("home_team_rank")
            ],
            'away_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_shots").alias("home_team_shots"),
                F.avg("away_team_shots").alias("away_team_shots"),
                F.avg("home_team_corners").alias("home_team_corners"),
                F.avg("away_team_corners").alias("away_team_corners"),
                F.avg("home_team_possession").alias("home_team_possession"),
                F.avg("away_team_possession").alias("away_team_possession"),
                F.avg("away_team_rank").alias("away_team_rank")
            ],
            
            'label': 'corners_total',
            'label_expr': F.col("home_team_corners") + F.col("away_team_corners"),
            'value_init': 6.5
        },
        'cards': {
            'features' :[ 
                "home_team_goals", "away_team_goals",
                "home_team_possession", "away_team_possession",
                "home_team_fouls", "away_team_fouls",
                "home_team_yellow_cards", "home_team_red_cards", 
                "away_team_yellow_cards", "away_team_red_cards",
                "home_team_yellow_cards_total", "home_team_red_cards_total",
                "away_team_yellow_cards_total", "away_team_red_cards_total",
                "home_team_rank", "away_team_rank"
            ],
            'home_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_fouls").alias("home_team_fouls"),
                F.avg("away_team_fouls").alias("away_team_fouls"),
                F.avg("home_team_yellow_cards").alias("home_team_yellow_cards"),
                F.avg("away_team_yellow_cards").alias("away_team_yellow_cards"),
                F.avg("home_team_red_cards").alias("home_team_red_cards"),
                F.avg("away_team_red_cards").alias("away_team_red_cards"),
                F.avg("home_team_possession").alias("home_team_possession"),
                F.avg("away_team_possession").alias("away_team_possession"),
                F.avg("home_team_yellow_cards_total").alias("home_team_yellow_cards_total"),
                F.avg("home_team_red_cards_total").alias("home_team_red_cards_total"),
                F.avg("home_team_rank").alias("home_team_rank")
            ],
            'away_features_agg' : [
                F.avg("home_team_goals").alias("home_team_goals"),
                F.avg("away_team_goals").alias("away_team_goals"),
                F.avg("home_team_fouls").alias("home_team_fouls"),
                F.avg("away_team_fouls").alias("away_team_fouls"),
                F.avg("home_team_yellow_cards").alias("home_team_yellow_cards"),
                F.avg("away_team_yellow_cards").alias("away_team_yellow_cards"),
                F.avg("home_team_red_cards").alias("home_team_red_cards"),
                F.avg("away_team_red_cards").alias("away_team_red_cards"),
                F.avg("home_team_possession").alias("home_team_possession"),
                F.avg("away_team_possession").alias("away_team_possession"),
                F.avg("away_team_yellow_cards_total").alias("away_team_yellow_cards_total"),
                F.avg("away_team_red_cards_total").alias("away_team_red_cards_total"),
                F.avg("away_team_rank").alias("away_team_rank")
            ],
            'label': 'cards_total',
            'label_expr': F.col("home_team_yellow_cards") + F.col("away_team_yellow_cards") + F.col("home_team_red_cards") + F.col("away_team_red_cards"),
            'value_init': 3.5
        }
    }