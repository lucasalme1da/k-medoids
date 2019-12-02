---Tabela auxiliares
--- Essas tabelas ajudam a calcular o novo representante de cada grupo 

select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into iris_setosa from dados where grupo_id = 1;
select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into iris_versicolor from dados where grupo_id = 2;
select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into iris_virginica from dados where grupo_id = 3;
alter table iris_setosa
	add column distancia_paragrupo real;
	
alter table iris_versicolor
	add column distancia_paragrupo real;
	
alter table iris_virginica
	add column distancia_paragrupo real;
	
alter table iris_setosa
	add column idi SERIAL;
	
alter table iris_versicolor
	add column idi SERIAL;
	
alter table iris_virginica
	add column idi SERIAL;