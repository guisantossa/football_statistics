from sqlalchemy.orm import Session
from decimal import Decimal, getcontext
from collections import defaultdict
from db import get_db, Bet, Bookmaker, Match
import re

getcontext().prec = 6  # mais precisão para odds

def parse_bet_value(bet_value_str):
    match = re.match(r"(Over|Under)\s?([\d.]+)", bet_value_str)
    if match:
        return match.group(1), match.group(2)
    return None, None


def find_arbitrage_all_types(db: Session, aposta_total: Decimal):
    casas_alvo = ["Betano", "Superbet"]
    
    bets = (
        db.query(Bet)
        .join(Bet.bookmaker)
        #.filter(Bookmaker.name.in_(casas_alvo))
        .join(Bet.match)
    )

    getcontext().prec = 6

    # ---------- TOTAL GOALS ----------
    from collections import defaultdict
    goal_bets = defaultdict(lambda: {"Over": [], "Under": []})
    
    for bet in bets:
        tipo, valor = parse_bet_value(bet.bet_value)
        if tipo in ["Over", "Under"]:
            key = (bet.match_id, bet.bet_type_id, valor)
            goal_bets[key][tipo].append(bet)
    
    for key, sides in goal_bets.items():
        for over in sides["Over"]:
            for under in sides["Under"]:
                if over.bookmaker_id == under.bookmaker_id:
                    continue
                odd_over = Decimal(over.odd)
                odd_under = Decimal(under.odd)
                inv = (1 / odd_over) + (1 / odd_under)
                if inv < 1:
                    match = over.match
                    print(f"\n🎯 Arbitragem (Total Goals {key[2]}) entre {match.home_team.name} vs {match.away_team.name}")
                    print(f"Over: {over.bookmaker.name} @ {odd_over}")
                    print(f"Under: {under.bookmaker.name} @ {odd_under}")
                    print(f"Inverso das odds: {inv:.4f}")

                    # Cálculo de quanto apostar em cada casa
                    aposta_over = (1 / odd_over) / inv * aposta_total
                    aposta_under = (1 / odd_under) / inv * aposta_total

                    # Lucro esperado
                    lucro_over = aposta_over * (odd_over - 1)
                    lucro_under = aposta_under * (odd_under - 1)

                    print(f"Valor a apostar em {over.bookmaker.name}: {aposta_over:.2f}")
                    print(f"Valor a apostar em {under.bookmaker.name}: {aposta_under:.2f}")
                    print(f"Lucro potencial: {lucro_over + lucro_under:.2f}")

    # ---------- RESULTADO FINAL ----------
    match_result_bets = defaultdict(lambda: {"Home": [], "Away": [], "Draw": []})

    for bet in bets:
        if bet.bet_value in ["Home", "Away", "Draw"]:
            key = (bet.match_id, bet.bet_type_id)
            match_result_bets[key][bet.bet_value].append(bet)
    
    for key, options in match_result_bets.items():
        home_bets = options["Home"]
        away_bets = options["Away"]
        draw_bets = options["Draw"]

        for h in home_bets:
            for a in away_bets:
                for d in draw_bets:
                    # Garante 3 casas diferentes
                    casas = {h.bookmaker_id, a.bookmaker_id, d.bookmaker_id}
                    if len(casas) < 2:
                        continue

                    odd_h = Decimal(h.odd)
                    odd_a = Decimal(a.odd)
                    odd_d = Decimal(d.odd)

                    inv = (1 / odd_h) + (1 / odd_a) + (1 / odd_d)

                    if inv < 1:
                        match = h.match
                        print(f"\n⚽ Arbitragem (1X2) para {match.home_team.name} vs {match.away_team.name}")
                        print(f"Home ({h.bookmaker.name}): {odd_h}")
                        print(f"Away ({a.bookmaker.name}): {odd_a}")
                        print(f"Draw ({d.bookmaker.name}): {odd_d}")
                        print(f"Inverso das odds: {inv:.4f}")

                        # Cálculo de quanto apostar em cada casa
                        aposta_h = (1 / odd_h) / inv * aposta_total
                        aposta_a = (1 / odd_a) / inv * aposta_total
                        aposta_d = (1 / odd_d) / inv * aposta_total

                        # Lucro esperado
                        lucro_h = aposta_h * (odd_h - 1)
                        lucro_a = aposta_a * (odd_a - 1)
                        lucro_d = aposta_d * (odd_d - 1)

                        print(f"Valor a apostar em {h.bookmaker.name} (Home): {aposta_h:.2f}")
                        print(f"Valor a apostar em {a.bookmaker.name} (Away): {aposta_a:.2f}")
                        print(f"Valor a apostar em {d.bookmaker.name} (Draw): {aposta_d:.2f}")
                        print(f"Lucro potencial: {lucro_h + lucro_a + lucro_d:.2f}")

                        
if __name__ == "__main__":
    db = get_db()
    find_arbitrage_all_types(db, 300)