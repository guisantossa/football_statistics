FROM python:3.11

ENV SPARK_HOME=/opt/spark

# Instalar dependências essenciais
RUN apt-get update && apt-get install -y \
    curl \
    default-jdk \
    bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Baixar e instalar Apache Spark
ENV SPARK_VERSION=3.5.0
ENV HADOOP_VERSION=3
RUN curl -fsSL "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    | tar -xz -C /opt/ && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

# Configurar variáveis do Spark
ENV PATH="$SPARK_HOME/bin:$PATH"

# Instalar o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Garantir que o Poetry esteja no PATH
ENV PATH="/root/.local/bin:$PATH"

# Copiar arquivos do projeto para o diretório /opt/app
COPY . /src/app

# Definir diretório de trabalho
WORKDIR /src/app 

# Instalar dependências do projeto usando o Poetry
RUN poetry install --no-root --verbose

