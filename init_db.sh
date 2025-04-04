#!/bin/bash
# Espera o PostgreSQL iniciar
echo "Esperando o PostgreSQL iniciar..."
sleep 10s  # Espera 10 segundos para garantir que o PostgreSQL esteja rodando

# Comando para verificar se o banco existe, se não, cria
psql -U root -d postgres -c "SELECT 1 FROM pg_database WHERE datname = 'sports_statistics'" | grep -q 1 || \
psql -U root -d postgres -c "CREATE DATABASE sports_statistics"

echo "Banco de dados 'sports_statistics' verificado/criado com sucesso."
