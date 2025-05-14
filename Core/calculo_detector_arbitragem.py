def verificar_arbitragem(odd1, odd2):
    inv1 = 1 / odd1
    inv2 = 1 / odd2
    total = inv1 + inv2

    if total < 1:
        lucro_percentual = (1 - total) * 100
        return True, round(lucro_percentual, 2)
    return False, 0.0


def calcular_apostas(odd1, odd2, total_aposta):
    inv1 = 1 / odd1
    inv2 = 1 / odd2
    total = inv1 + inv2

    proporcao1 = inv1 / total
    proporcao2 = inv2 / total

    valor1 = total_aposta * proporcao1
    valor2 = total_aposta * proporcao2

    retorno = round(valor1 * odd1, 2)  # mesmo retorno nos dois casos

    lucro = round(retorno - total_aposta, 2)

    return round(valor1, 2), round(valor2, 2), retorno, lucro


# Exemplo de uso:
odd_mais = 1.92
odd_menos = 1.76
banca = 100

tem_arbitragem, lucro_percent = verificar_arbitragem(odd_mais, odd_menos)

if tem_arbitragem:
    print(f"\n✅ Existe arbitragem! Lucro estimado: {lucro_percent}%")
    valor_mais, valor_menos, retorno, lucro = calcular_apostas(odd_mais, odd_menos, banca)
    print(f"Aposte R${valor_mais} em +2,5 gols (odd {odd_mais})")
    print(f"Aposte R${valor_menos} em -2,5 gols (odd {odd_menos})")
    print(f"Retorno garantido: R${retorno} → Lucro: R${lucro}")
else:
    print("\n❌ Não há arbitragem com essas odds.")
