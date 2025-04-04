from db import create_tables

if __name__ == "__main__":
    try:
        create_tables()
        print("Tabelas criadas com sucesso!!!!")
    except Exception as e:
        print(f"Erro ao criar tabelas: {e}")
