# Football Statistics

## 📌 Visão Geral
Football Statistics é um sistema de gerenciamento esportivo focado na coleta, processamento e visualização de estatísticas do futebol. O projeto utiliza uma arquitetura baseada em **AWS EC2, RDS, Docker, Airflow, Spark e Streamlit** para garantir escalabilidade e eficiência no processamento e exibição dos dados.

## 🏗️ Estrutura do Projeto
A infraestrutura do projeto é baseada em conteinerização, permitindo uma implementação modular e escalável:

- **EC2 (AWS)**: Instância principal para hospedar os containers do projeto.
- **RDS (AWS)**: Banco de dados gerenciado para armazenamento das estatísticas.
- **Docker**: Gerenciamento dos containers do projeto.
- **Airflow**: Orquestração e automação dos processos de coleta e processamento de dados.
- **Spark**: Processamento distribuído para análise de grandes volumes de dados.
- **Streamlit**: Interface interativa para visualização das estatísticas.

## 🔧 Configuração Inicial

### 1️⃣ Criar Instância EC2 na AWS
1. Escolher uma AMI Linux (Ubuntu recomendado).
2. Configurar regras de segurança (permitir SSH e acessos necessários para os containers).
3. Instalar Docker e Docker Compose na instância.

### 2️⃣ Criar o Banco de Dados RDS
1. Escolher PostgreSQL ou MySQL.
2. Configurar conexão segura e permissões de acesso.
3. Criar tabelas iniciais conforme a modelagem do projeto.

### 3️⃣ Configurar Docker e Containers
Criar um `docker-compose.yml` para gerenciar os containers:
- **Python**: Aplicativo principal.
- **Airflow**: Orquestração dos fluxos de dados.
- **Spark**: Processamento de estatísticas.
- **Streamlit**: Interface web para visualização.

### 4️⃣ Testar a Comunicação Entre os Serviços
- Garantir que os containers conseguem se comunicar corretamente.
- Verificar conexão com o banco de dados.
- Rodar DAGs no Airflow para validar o fluxo de processamento.

## 🚀 Próximos Passos
- Implementar os primeiros pipelines de coleta de dados.
- Criar a interface básica do Streamlit.
- Otimizar configuração do Spark para maior eficiência.

---
Este documento será atualizado conforme o projeto avançar. Qualquer dúvida ou sugestão, entre em contato!

