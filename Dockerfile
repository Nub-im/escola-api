# 1. Define a imagem base
# Usamos uma imagem oficial do Python, a versão 'slim' é menor e ideal para produção.
FROM python:3.11-slim-buster

# 2. Definir o diretório de trabalho dentro do contêiner
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar o arquivo de dependências
# Copiamos primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# 4. Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o código da aplicação
COPY . .

# 6. Expor a porta que a aplicação usará
EXPOSE 8000

# 7. Comando para executar a aplicação
# Usamos uvicorn para rodar a aplicação. O host 0.0.0.0 torna a aplicação acessível
# de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]