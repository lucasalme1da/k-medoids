-- Algoritmo de K-Medoids Implementado na linguagem PL/pgSQL (PostgreSQL)
-- Agradecimento aos colaboradores: 
-- Arthur Vinicius Fogaça de Andrade, Lucas de Almeida, Thiago Angelo Martins e Vinicius Augusto de Souza

-- set search_path to public; [[[TESTES - APAGAR]]]

-- Inicialmente, cria-se uma tabela que receberá as 4 variáveis representando
-- as medidas das pétalas e das sépalas referente ao conjunto de dados do IRIS, 
-- bem como uma ultima coluna contendo a classe em que cada tupla se encaixa.
CREATE TABLE valoresTeoricos (
	w DECIMAL,
	x DECIMAL,
	y DECIMAL,
	z DECIMAL,
	classe VARCHAR(45)
);

-- Copiando os valores do conjunto de dados de exemplo para uma tabela
-- no banco de dados chamada 'valoresTeoricos'.
COPY valoresTeoricos
FROM 'C:\dataset.csv' DELIMITER ',' CSV HEADER;

--INSERT INTO valoresTeoricos values(5.1, 3.5, 1.4, 0.2, 'Iris-setosa') [[[TESTES - APAGAR]]]

--DELETE FROM valoresTeoricos; [[[TESTES - APAGAR]]]

-- Criando uma tabela vazia para abrigar os k-medoids.
CREATE TABLE medoids (
	w DECIMAL,
	x DECIMAL,
	y DECIMAL,
	z DECIMAL
)

-- Criando uma função que escolhe um número 'k' de tuplas aleatorias na tabela
-- de entrada ('valoresTeoricos'), as quais serao os medoids iniciais. A função já insere
-- os 'k' medoids aleatórios na tabela 'medoids'.
CREATE OR REPLACE FUNCTION selecionar_k_medoids_iniciais(k INTEGER)
	RETURNS text AS $$
	DECLARE
		reg medoids%rowtype;
		N INTEGER;
	BEGIN	
		SELECT INTO N COUNT(*) FROM valoresTeoricos; -- Conta numero de tuplas em valoresTeoricos
		DELETE FROM medoids; -- Limpa a tabela de medoids atuais
		-- Insere w,x,y,z da tabela valoresTeoricos k vezes na tabela medoids:
      	INSERT INTO medoids SELECT w,x,y,z FROM valoresTeoricos OFFSET floor(random()*N) LIMIT k;
		RETURN 'Executado com sucesso!';
	END;
$$ language plpgsql;

-- Utilizando a funcao criada para escolher 'k' = 3 medoids aleatórios.
SELECT * FROM selecionar_k_medoids_iniciais(3)

-- Verificando medoids escolhidos
SELECT * FROM medoids;

-- Salvando arquivo CSV [[[[TESTES APENAS, APAGARRR]]]]
copy (SELECT m.w, m.x, m.y, m.z, v.w, v.x, v.y, v.z from valoresteoricos v cross join medoids m) to 'C:\Users\Lucas Almeida\Desktop\euclidian.csv' with csv

-- Chamemos os medoids de 'x' e os valores teoricos de 'y'
-- Criando a tabela 'distanciaseuclidianas' que contem a relacao entre valores teoricos e medoids,
-- bem como a distancia euclidiana entre eles.
SELECT m.w as x0, m.x as x1, m.y as x2, m.z as x3, v.w as y0, v.x as y1, v.y as y2, v.z as y3, SQRT(POWER(m.w - v.w,2) + POWER(m.x - v.x,2) + POWER(m.y - v.y,2) + POWER(m.z - v.z,2)) AS "Distância Euclidiana" INTO distanciaseuclidianas FROM valoresteoricos v CROSS JOIN medoids m;

-- Enumerando as linhas da tabela 'distanciaseuclidianas' para entao fazer a verificacao de grupos.
ALTER TABLE distanciaseuclidianas ADD COLUMN id SERIAL PRIMARY KEY;

-- Criando uma tabela temporaria que contém o grupo a qual cada tupla em 'valoresTeoricos' melhor se 
-- encaixa, com base nos medoids iniciais.
create table temp_ans(
	grupo INTEGER
)

-- Criando uma funcao que realiza a verificacao de grupos com base na menor distancia euclidiana
CREATE OR REPLACE FUNCTION calcular_distancia_euclidiana()
	RETURNS text AS $$
	DECLARE
		quantidade_valores_teoricos INTEGER;
		quantidade_medoids INTEGER;
		grupo INTEGER;
		valor DECIMAL;
		menor DECIMAL default 100000.0;
	BEGIN	
		-- Contando numero de tuplas em 'valoresteoricos'
		SELECT count(w) INTO quantidade_valores_teoricos FROM valoresteoricos;
		-- Contando numero de medoids em 'medoids'
		SELECT count(w) INTO quantidade_medoids FROM medoids;
		-- Utilizando um laço de repeticao para verificar os grupos de cada tupla com
		-- base na menor distancia
		FOR i IN 1..quantidade_valores_teoricos LOOP
			FOR j IN 1..quantidade_medoids LOOP
				SELECT "Distância Euclidiana" INTO valor 
				FROM distanciaseuclidianas
				WHERE id = i + quantidade_valores_teoricos * (j - 1);
				IF (valor < menor) THEN
					menor := valor;
					grupo := j;
					RAISE NOTICE 'Valor -> %', valor;
				END IF;
				RAISE NOTICE '-----------';
			END LOOP;
			INSERT INTO temp_ans values(grupo);
			menor := 100000.0;
			valor := 0.0;
   		END LOOP;
		--RAISE NOTICE 'Quantidade de valores teoricos -> %', quantidade_valores_teoricos;
		RETURN 'Executado com sucesso!';
	END;
$$ language plpgsql;

-- Função que limpa a tabela 'temp_ans'. [[[APENAS TESTES, APAGAR]]]
delete from temp_ans;

-- Testando a função de calculo de distancia euclidiana. [[[APENAS TESTES, APAGAR]]]
SELECT * FROM calcular_distancia_euclidiana();

-- Visualizando em qual grupo cada tupla se encaixa melhor, com base nos medoids atuais. [[[APENAS TESTES, APAGAR]]]
select * from temp_ans;

