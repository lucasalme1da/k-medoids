# k-medoids
Implementação do algoritmo de agrupamento em "K-Medoids" utilizando PL/pgSQL (PostgreSQL)
--

# Primeiro passo 
  
  - Escolher o número de medoids k.

  - Escolher k medoids aleatórios entre os pontos( três pontos aleatórios serão escolhidos e chamados de medoids), pegar três pontos aleatóriamente no conjunto para serem os medoids.

 - Calcular a distância euclidiana para cada medoid para todos os outros pontos.

 - Para cada ponto, ver qual a distancia é menor entre o ponto e os k medoids, o ponto 
fará parte do grupo do medoid que estiver mais próximo.

# Segundo passo

- Procurar o melhor representande de cada grupo, calcular a distância para cada ponto do grupo para todos do mesmo grupo, somar e armazenar essa soma como atributo deste ponto.

- Escolher o ponto que tiver o valor mínimo, pois será o que estã mais próximo na média de todos os outros do mesmo grupo. Então este ponto se tornará o novo medoid.

- Fazer isso para todos os outros grupos escolhendo e reatribuindo os medoids.

# Terceiro passo

- Refazer o processo do primeiro passo mas desta vez com os medoids definidos, parar a iteração quando os pontos não mudarem mais de grupo, ou então parar com um número máximo de iterações.

- Para verificar se o algoritmo funcionou, os grupos tem que estar separados da mesma maneira que o arquivo original.

# Execução do Algoritmo

- Criar um database no PostgresSQL

- Criar uma Query Tool no schema public, gerado automaticamente

- Copiar todo o algoritmo do arquivo "alogoritmoKmedoidCompleto.sql" e colar na query

- Executar todo o código
