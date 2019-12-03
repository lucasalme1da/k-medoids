-- Algoritmo de K-Medoids Implementado na linguagem PL/pgSQL (PostgreSQL)
-- Agradecimento aos colaboradores: 
-- Arthur Vinicius Fogaça de Andrade, Lucas de Almeida, Thiago Angelo Martins e Vinicius Augusto de Souza

-- set search_path to public; [[[TESTES - APAGAR]]]

-- Inicialmente, cria-se uma tabela que receberá as 4 variáveis representando
-- as medidas das pétalas e das sépalas referente ao conjunto de dados do IRIS, 
-- bem como uma ultima coluna contendo a classe em que cada tupla se encaixa.
-- CREATE TABLE dados (
-- 	w DECIMAL,
-- 	x DECIMAL,
-- 	y DECIMAL,
-- 	z DECIMAL,
-- 	classe VARCHAR(45)
-- );

CREATE TABLE dados(
   w      NUMERIC(3,1) NOT NULL PRIMARY KEY ,
   x      NUMERIC(3,1) NOT NULL,
   y      NUMERIC(3,1) NOT NULL,
   z      NUMERIC(3,1) NOT NULL,
   classe VARCHAR(35) NOT NULL
);
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.5,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,3.0,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.7,3.2,1.3,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.6,3.1,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.6,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.9,1.7,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.6,3.4,1.4,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.4,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.4,2.9,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,3.1,1.5,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.7,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.8,3.4,1.6,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.8,3.0,1.4,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.3,3.0,1.1,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,4.0,1.2,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,4.4,1.5,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.9,1.3,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.5,1.4,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,3.8,1.7,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.8,1.5,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.4,1.7,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.7,1.5,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.6,3.6,1.0,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.3,1.7,0.5,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.8,3.4,1.9,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.0,1.6,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.4,1.6,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.2,3.5,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.2,3.4,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.7,3.2,1.6,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.8,3.1,1.6,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.4,1.5,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.2,4.1,1.5,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,4.2,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,3.1,1.5,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.2,1.2,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,3.5,1.3,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,3.1,1.5,0.1,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.4,3.0,1.3,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.4,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.5,1.3,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.5,2.3,1.3,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.4,3.2,1.3,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.5,1.6,0.6,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.8,1.9,0.4,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.8,3.0,1.4,0.3,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,3.8,1.6,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.6,3.2,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.3,3.7,1.5,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,3.3,1.4,0.2,'Iris-setosa');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.0,3.2,4.7,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,3.2,4.5,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.9,3.1,4.9,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,2.3,4.0,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.5,2.8,4.6,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,2.8,4.5,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,3.3,4.7,1.6,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,2.4,3.3,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.6,2.9,4.6,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.2,2.7,3.9,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,2.0,3.5,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.9,3.0,4.2,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,2.2,4.0,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,2.9,4.7,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,2.9,3.6,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.1,4.4,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,3.0,4.5,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.7,4.1,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.2,2.2,4.5,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,2.5,3.9,1.1,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.9,3.2,4.8,1.8,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,2.8,4.0,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.5,4.9,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,2.8,4.7,1.2,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,2.9,4.3,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.6,3.0,4.4,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.8,2.8,4.8,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.0,5.0,1.7,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,2.9,4.5,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,2.6,3.5,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,2.4,3.8,1.1,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,2.4,3.7,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.7,3.9,1.2,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,2.7,5.1,1.6,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.4,3.0,4.5,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,3.4,4.5,1.6,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.1,4.7,1.5,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.3,4.4,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,3.0,4.1,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,2.5,4.0,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.5,2.6,4.4,1.2,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,3.0,4.6,1.4,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.6,4.0,1.2,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.0,2.3,3.3,1.0,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,2.7,4.2,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,3.0,4.2,1.2,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,2.9,4.2,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.2,2.9,4.3,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.1,2.5,3.0,1.1,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,2.8,4.1,1.3,'Iris-versicolor');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,3.3,6.0,2.5,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.7,5.1,1.9,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.1,3.0,5.9,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.9,5.6,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.5,3.0,5.8,2.2,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.6,3.0,6.6,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (4.9,2.5,4.5,1.7,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.3,2.9,6.3,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,2.5,5.8,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.2,3.6,6.1,2.5,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.5,3.2,5.1,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,2.7,5.3,1.9,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.8,3.0,5.5,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.7,2.5,5.0,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.8,5.1,2.4,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,3.2,5.3,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.5,3.0,5.5,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.7,3.8,6.7,2.2,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.7,2.6,6.9,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,2.2,5.0,1.5,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.9,3.2,5.7,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.6,2.8,4.9,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.7,2.8,6.7,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.7,4.9,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.3,5.7,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.2,3.2,6.0,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.2,2.8,4.8,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,3.0,4.9,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,2.8,5.6,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.2,3.0,5.8,1.6,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.4,2.8,6.1,1.9,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.9,3.8,6.4,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,2.8,5.6,2.2,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.8,5.1,1.5,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.1,2.6,5.6,1.4,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (7.7,3.0,6.1,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,3.4,5.6,2.4,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.4,3.1,5.5,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.0,3.0,4.8,1.8,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.9,3.1,5.4,2.1,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.1,5.6,2.4,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.9,3.1,5.1,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.8,2.7,5.1,1.9,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.8,3.2,5.9,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.3,5.7,2.5,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.7,3.0,5.2,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.3,2.5,5.0,1.9,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.5,3.0,5.2,2.0,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (6.2,3.4,5.4,2.3,'Iris-virginica');
INSERT INTO dados(dados_eixo_w,dados_eixo_x,dados_eixo_y,dados_eixo_z, classeOriginal) VALUES (5.9,3.0,5.1,1.8,'Iris-virginica');


-- -- Copiando os valores do conjunto de dados de exemplo para uma tabela
-- -- no banco de dados chamada 'dados'.
-- COPY dados
-- FROM 'C:\dataset.csv' DELIMITER ',' CSV HEADER;

--INSERT INTO dados values(5.1, 3.5, 1.4, 0.2, 'Iris-setosa') [[[TESTES - APAGAR]]]

--DELETE FROM dados; [[[TESTES - APAGAR]]]



-- Criando uma tabela vazia para abrigar os k-medoids.
CREATE TABLE medoids (
	w DECIMAL,
	x DECIMAL,
	y DECIMAL,
	z DECIMAL
)

-- Criando uma função que escolhe um número 'k' de tuplas aleatorias na tabela
-- de entrada ('dados'), as quais serao os medoids iniciais. A função já insere
-- os 'k' medoids aleatórios na tabela 'medoids'.
CREATE OR REPLACE FUNCTION selecionar_k_medoids_iniciais(k INTEGER)
	RETURNS text AS $$
	DECLARE
		reg medoids%rowtype;
		N INTEGER;
	BEGIN	
		SELECT INTO N COUNT(*) FROM dados; -- Conta numero de tuplas em dados
		DELETE FROM medoids; -- Limpa a tabela de medoids atuais
		-- Insere w,x,y,z da tabela dados k vezes na tabela medoids:
      	INSERT INTO medoids SELECT w,x,y,z FROM dados OFFSET floor(random()*N) LIMIT k;
		RETURN 'Executado com sucesso!';
	END;
$$ language plpgsql;

-- Utilizando a funcao criada para escolher 'k' = 3 medoids aleatórios.
SELECT * FROM selecionar_k_medoids_iniciais(3)

-- Verificando medoids escolhidos
SELECT * FROM medoids;

-- Salvando arquivo CSV [[[[TESTES APENAS, APAGARRR]]]]
copy (SELECT m.w, m.x, m.y, m.z, v.w, v.x, v.y, v.z from dados v cross join medoids m) to 'C:\Users\Lucas Almeida\Desktop\euclidian.csv' with csv

-- Chamemos os medoids de 'x' e os valores teoricos de 'y'
-- Criando a tabela 'distanciaseuclidianas' que contem a relacao entre valores teoricos e medoids,
-- bem como a distancia euclidiana entre eles.
SELECT m.w as x0, m.x as x1, m.y as x2, m.z as x3, v.w as y0, v.x as y1, v.y as y2, v.z as y3, SQRT(POWER(m.w - v.w,2) + POWER(m.x - v.x,2) + POWER(m.y - v.y,2) + POWER(m.z - v.z,2)) AS "Distância Euclidiana" INTO distanciaseuclidianas FROM dados v CROSS JOIN medoids m;

-- Enumerando as linhas da tabela 'distanciaseuclidianas' para entao fazer a verificacao de grupos.
ALTER TABLE distanciaseuclidianas ADD COLUMN id SERIAL PRIMARY KEY;

-- Criando uma tabela temporaria que contém o grupo a qual cada tupla em 'dados' melhor se 
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
		-- Contando numero de tuplas em 'dados'
		SELECT count(w) INTO quantidade_valores_teoricos FROM dados;
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

