create table if not exists dados(
    dados_id SERIAL,
    dados_eixo_w NUMERIC(3,1),
    dados_eixo_x NUMERIC(3,1),
    dados_eixo_y NUMERIC(3,1),
    dados_eixo_z NUMERIC(3,1),
	classeOriginal VARCHAR(35),
    grupo_id integer, --Grupo no qual vai pertencer
	grupo_id_anterior integer,
    CONSTRAINT pkDados PRIMARY KEY (dados_id)
);

create table if NOT exists grupo(
    grupo_id integer,
    grupo_nome text,
    grupo_k_methoid integer,
    constraint pkGrupo primary key (grupo_id)
);

CREATE SEQUENCE if not exists medoids_id_seq;
 
CREATE TABLE if not exists medoids (
	w numeric(3,1),
	x numeric(3,1),
	y numeric(3,1),
	z numeric(3,1),
    medoids_id integer NOT NULL DEFAULT nextval('medoids_id_seq'), --Grupo no qual o medoids representa
    constraint pkMedoids primary key (medoids_id)
);

ALTER SEQUENCE medoids_id_seq OWNED BY medoids.medoids_id;

create or replace function popularTabelas() returns void as $$
	declare
		gruposQuantidade integer := 0;
		dadosQuantidade integer := 0;
	begin
		SELECT count(*)
		FROM grupo into gruposQuantidade;
		
		SELECT count(*)
		FROM dados into dadosQuantidade;

		if gruposQuantidade = 0 then
			insert into grupo values(1,'iris_setosa',null);
			insert into grupo values(2,'iris_versicolor',null);
			insert into grupo values(3,'iris_virginica',null);
		end if;

		if dadosQuantidade = 0 then
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
		end if;

	end;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION selecionar_k_medoids_iniciais(k INTEGER)
	RETURNS text AS $$
	DECLARE
		reg medoids%rowtype;
		N INTEGER;
	BEGIN	
		SELECT INTO N COUNT(*) FROM dados; -- Conta numero de tuplas em valoresTeoricos
		DELETE FROM medoids; -- Limpa a tabela de medoids atuais
		ALTER SEQUENCE medoids_id_seq RESTART WITH 1;
		-- Insere w,x,y,z da tabela valoresTeoricos k vezes na tabela medoids:
      	INSERT INTO medoids 
		SELECT dados_eixo_w,
         dados_eixo_x,
         dados_eixo_y,
         dados_eixo_z
		FROM dados OFFSET floor(random()*N) LIMIT k;
		RETURN 'Executado com sucesso!';
	END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION calcular_distancia_euclidiana()
	RETURNS text AS $$

    -- DECLARAÇÃO DE VARIAVERIS
	DECLARE
		quantidade INTEGER;
		quantidade_medoids INTEGER;
		
		--Valores das distancia
		valor_distancia DECIMAL default 0.0;
		menor_distancia DECIMAL default 0.0;

        tuplaDADOS dados%ROWTYPE;
        tuplaMETHOID medoids%ROWTYPE;
	
	BEGIN
		-- Contando numero de tuplas em 'dados'
		SELECT count(dados_id) INTO quantidade
		FROM dados;

		-- Contando numero de medoids em 'medoids'
		SELECT count(w) INTO quantidade_medoids
		FROM medoids;

		--LOOP EXTERNO PERCORRE TODOS DADOS 
		FOR i IN 1..quantidade LOOP
			--PEGANDO VALORES DOS DADOS
			SELECT * into tuplaDADOS
			FROM dados
			WHERE dados_id = i;

			--LOOP SOBRE OS METHOIDS
			FOR j IN 1..quantidade_medoids LOOP
				
				SELECT * into tuplaMETHOID
				FROM medoids
				WHERE medoids_id = j;			

				valor_distancia = SQRT(POWER(tuplaMETHOID.w - tuplaDADOS.dados_eixo_w,2) + POWER(tuplaMETHOID.x - tuplaDADOS.dados_eixo_x,2) + POWER(tuplaMETHOID.y - tuplaDADOS.dados_eixo_y,2) + POWER(tuplaMETHOID.z - tuplaDADOS.dados_eixo_z,2));
				--raise notice 'VALOR DISTANCIA % -> %', j,valor_distancia;

				-- VERIFICANDO QUAL METHOIDS VAI CONQUISTAR O DADO
				if (menor_distancia = 0.0)then
					menor_distancia = valor_distancia;

					UPDATE dados SET grupo_id = j
					WHERE dados_id = i;

					CONTINUE;
				end if;
				
				if (valor_distancia < menor_distancia)then
					menor_distancia = valor_distancia;

					UPDATE dados SET grupo_id = j
					WHERE dados_id = i;

					--raise notice 'grupo -> %',j;
				end if;

			END LOOP;
			menor_distancia = 0.0;
		END LOOP;
		RETURN 'Executado com sucesso!';
		--RAISE NOTICE 'Quantidade de valores teoricos -> %', quantidade_valores_teoricos;
	END;
$$ language plpgsql;

--Função responsavel por calcular novo methoid
--Os  raise notice disperso pelo código são para testar valor
-- Os valores estão divididos por 100 por um problema de overflow
create or replace function calculaNovoKmethoid() returns text as $$ 
	declare
	quantidade integer;
	distancia_paragrupoValor decimal default 0.0;
	pontoInicial dados%rowtype;
	pontoFinal dados%rowtype;
	Novomethoid RECORD;
	begin

	create table iris_setosa AS
	SELECT *
	FROM dados
	WHERE grupo_id = 1;

	create table iris_versicolor AS
	SELECT *
	FROM dados
	WHERE grupo_id = 2;

	create table iris_virginica AS
	SELECT *
	FROM dados
	WHERE grupo_id = 3;
	
	alter table iris_setosa
	add column distancia_paragrupo real;
	
	alter table iris_versicolor
	add column distancia_paragrupo real;
	
	alter table iris_virginica add column distancia_paragrupo real;
	
	alter table iris_setosa add column idi SERIAL, 
	add constraint pkIrisSetosa primary key (idi);
	
	alter table iris_versicolor add column idi SERIAL, 
	add constraint pkIrisVersiColor primary key (idi);
	
	alter table iris_virginica add column idi SERIAL, 
	add constraint pkIrisVirginica primary key (idi);

	UPDATE iris_setosa SET distancia_paragrupo = 0.0;

	UPDATE iris_versicolor SET distancia_paragrupo = 0.0;

	UPDATE iris_virginica SET distancia_paragrupo = 0.0;
    

	---------------------> Iris-Setosa <------------------
	--Selecionando quantidade de tuplas para fazer o LOOP
	SELECT count(idi) into quantidade
	FROM iris_setosa;
	--raise notice 'quantidade %',quantidade;
	
	for i in 1..quantidade loop
		--raise notice 'idi % ',i;
		
		SELECT * into pontoInicial
		FROM iris_setosa
		WHERE idi = i;
		
		--raise notice 'pontoInicial %', pontoInicial;
	
		for j in 1..quantidade loop
			--raise notice 'j %', j;
			
			SELECT * into pontoFinal
			FROM iris_setosa
			WHERE idi = j;

			--raise notice 'valor %', pontoFinal.dados_eixo_w;

			-- Calculando distancia 
			distancia_paragrupoValor = (SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 +
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			------------------------------------
			
			
		end loop;
		--raise notice 'idi % valor %',i,distancia_paragrupoValor;
		
		---Colocando a distancia calculada na tabela----
		UPDATE iris_setosa SET distancia_paragrupo = distancia_paragrupoValor
		WHERE idi = i; distancia_paragrupoValor = 0.0;

	end loop;
	
	-----------------------> Iris-versicolor <------------------------------------
	SELECT count(idi) into quantidade
	FROM iris_versicolor;
	
	for i in 1..quantidade loop

		SELECT * into pontoInicial
		FROM iris_versicolor
		WHERE idi = i;

		--raise notice 'pontoInicial %', pontoInicial;

		--Iterando sobre o grupo
		for j in 1..quantidade loop
			SELECT * into pontoFinal
			FROM iris_versicolor
			WHERE idi = j;

			--raise notice 'valor %', pontoFinal.dados_eixo_w;
			distancia_paragrupoValor = (SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 +
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			--raise notice 'valor %', distancia_paragrupoValor;
		end loop;

		---Colocando a distancia calculada na tabela
		UPDATE iris_versicolor SET distancia_paragrupo = distancia_paragrupoValor
		WHERE idi = i; distancia_paragrupoValor = 0;
		
	end loop;
	-----------------------------------------------------------------------
	
	----------------------> Iris-virginica <---------------------------------------
	SELECT count(idi) into quantidade
	FROM iris_virginica;
	
	for i in 1..quantidade loop
		SELECT * into pontoInicial
		FROM iris_virginica
		WHERE idi = i;

		--raise notice 'pontoInicial %', pontoInicial;
		for j in 1..quantidade loop
			SELECT * into pontoFinal
			FROM iris_virginica
			WHERE idi = j;

			--raise notice 'valor %', pontoFinal.dados_eixo_w;
			distancia_paragrupoValor = (SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 + 
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			--raise notice 'valor %', distancia_paragrupoValor;
		end loop;

		---Colocando a distancia calculada na tabela
		UPDATE iris_virginica SET distancia_paragrupo = distancia_paragrupoValor
		WHERE idi = i; distancia_paragrupoValor = 0.0;
	end loop;
	--------------------------------------------------------------------------------------
	
	------Selecionando novo methoid do grupo "IRIS-SETOSA"------
	SELECT dados_eixo_w,
         dados_eixo_x,
         dados_eixo_y,
         dados_eixo_z into Novomethoid
	FROM iris_setosa
	WHERE distancia_paragrupo = 
    	(SELECT min(distancia_paragrupo)
    FROM iris_setosa);
	
	UPDATE medoids SET w = Novomethoid.dados_eixo_w
	WHERE medoids_id = 1;
	UPDATE medoids SET x = Novomethoid.dados_eixo_x
	WHERE medoids_id = 1;
	UPDATE medoids SET y = Novomethoid.dados_eixo_y
	WHERE medoids_id = 1;
	UPDATE medoids SET z = Novomethoid.dados_eixo_z
	WHERE medoids_id= 1;

	raise notice 'Novo medoid 1 -> % % % %',Novomethoid.dados_eixo_w,Novomethoid.dados_eixo_x,Novomethoid.dados_eixo_y,Novomethoid.dados_eixo_z;
	---------------------------------------------------------------
	------Selecionando novo methoid do grupo "IRIS-VERSICOLOR"------
	SELECT dados_eixo_w,
         dados_eixo_x,
         dados_eixo_y,
         dados_eixo_z into Novomethoid
	FROM iris_versicolor
	WHERE distancia_paragrupo = 
    	(SELECT min(distancia_paragrupo)
    FROM iris_versicolor);
	
	UPDATE medoids SET w = Novomethoid.dados_eixo_w
	WHERE medoids_id = 2;
	UPDATE medoids SET x = Novomethoid.dados_eixo_x
	WHERE medoids_id = 2;
	UPDATE medoids SET y = Novomethoid.dados_eixo_y
	WHERE medoids_id = 2;
	UPDATE medoids SET z = Novomethoid.dados_eixo_z
	WHERE medoids_id= 2;

	raise notice 'Novo medoid 2 -> % % % %',Novomethoid.dados_eixo_w,Novomethoid.dados_eixo_x,Novomethoid.dados_eixo_y,Novomethoid.dados_eixo_z;

	---------------------------------------------------------------------------------------------
	------Selecionando novo methoid do grupo "IRIS-VIRGINICA"------
	SELECT dados_eixo_w,
         dados_eixo_x,
         dados_eixo_y,
         dados_eixo_z into Novomethoid
	FROM iris_virginica
	WHERE distancia_paragrupo = 
    	(SELECT min(distancia_paragrupo)
    FROM iris_virginica);
	
	UPDATE medoids SET w = Novomethoid.dados_eixo_w
	WHERE medoids_id = 3;
	UPDATE medoids SET x = Novomethoid.dados_eixo_x
	WHERE medoids_id = 3;
	UPDATE medoids SET y = Novomethoid.dados_eixo_y
	WHERE medoids_id = 3;
	UPDATE medoids SET z = Novomethoid.dados_eixo_z
	WHERE medoids_id= 3;

	raise notice 'Novo medoid 3 -> % % % %',Novomethoid.dados_eixo_w,Novomethoid.dados_eixo_x,Novomethoid.dados_eixo_y,Novomethoid.dados_eixo_z;


	drop table if EXISTS iris_setosa; 
	drop table if EXISTS iris_versicolor; 
	drop table if EXISTS iris_virginica;

	return 'Executado com sucesso';
	end
$$ language plpgsql;


create or replace function defineGrupoIdAnterior() returns boolean as $$
	declare
		quantidadeDados integer;
		tuplaDados dados%ROWTYPE;
		valoresIguais integer := 0;
	begin
		
		SELECT count(*) into quantidadeDados
		FROM dados;

		for i in 1..quantidadeDados loop
			SELECT * into tuplaDados
			FROM dados
			WHERE dados_id = i;

			if tuplaDados.grupo_id = tuplaDados.grupo_id_anterior and tuplaDados.grupo_id is not null then 
				valoresIguais = valoresIguais + 1;
			end if;			

		end loop;

		raise notice 'valores iguais %, quantidade %',valoresIguais,quantidadeDados;

		if valoresIguais = quantidadeDados then 
			return true;
		else 
			valoresIguais = 0;

			for i in 1..quantidadeDados loop
				UPDATE dados SET grupo_id_anterior = grupo_id
				WHERE dados_id = i;
			end loop;
			return false;
		end if;

	end
$$ language plpgsql;

create or replace function algoritmoMedoid() returns text as $$
	declare
		numeroMaximoIteracoes integer := 50;
		numeroDeMedoids integer := 3;
		condicaoDeParada boolean := false;
	begin
		-- Popula as tabelas de dados e grupos
		perform popularTabelas();

		-- Seleciona a quantidade de medoids aleatórios e coloca na tabela medoids
		perform selecionar_k_medoids_iniciais(numeroDeMedoids);

		UPDATE dados SET grupo_id = null;
		UPDATE dados SET grupo_id_anterior = null;

		--Itera até o máximo de iterações ou até os grupos convergirem
		for i in 1..numeroMaximoIteracoes loop
	
			SELECT defineGrupoIdAnterior() into condicaoDeParada;
			-- Checa se os valores para grupo_id mudam, pois se mudarem a iteração para

			if condicaoDeParada then
				exit;
			else 
				--Calcula a distancia euclidiana entre os medoids e todos os pontos
				-- e atribui um grupo para cada ponto
				perform calcular_distancia_euclidiana();

				--Calcula qual é a melhor escolha para novo medoid entre os grupos 
				perform calculaNovoKmethoid();
			end if;

		end loop;


		return 'Medoids Definidos';

	end
$$ language plpgsql;

SELECT algoritmoMedoid();

SELECT dados.grupo_id,
        classeoriginal,
        grupo_nome
FROM dados,grupo
WHERE dados.grupo_id = grupo.grupo_id
ORDER BY  dados.grupo_id asc;