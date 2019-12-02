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

	---------------------> Iris-Setosa <------------------
	--Selecionando quantidade de tuplas para fazer o LOOP
	select count(idi) into quantidade from iris_setosa;
	--raise notice 'quantidade %',quantidade;
	
	for i in 1..quantidade loop
		--raise notice 'idi % ',i;
		
		select * into pontoInicial from iris_setosa where idi = i;
		--raise notice 'pontoInicial %', pontoInicial;
	
		for j in 1..quantidade loop
			--raise notice 'j %', j;
			
			select * into pontoFinal from iris_setosa where idi = j;
			--raise notice 'valor %', pontoFinal.dados_eixo_w;

			-- Calculando distancia 
			distancia_paragrupoValor = (SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 +
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			------------------------------------
			--raise notice 'valor %', distancia_paragrupoValor;
			
		end loop;
		---Colocando a distancia calculada na tabela----
		update iris_setosa set distancia_paragrupo = distancia_paragrupoValor where idi = i;
		distancia_paragrupoValor = 0.0;
	end loop;
	
	-----------------------> Iris-versicolor <------------------------------------
	select count(idi) into quantidade from iris_versicolor;
	
	for i in 1..quantidade loop

		select * into pontoInicial from iris_versicolor where idi = i;
		--raise notice 'pontoInicial %', pontoInicial;

		--Iterando sobre o grupo
		for j in 1..quantidade loop
			select * into pontoFinal from iris_versicolor where idi = j;
			--raise notice 'valor %', pontoFinal.dados_eixo_w;
			distancia_paragrupoValor = SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 +
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			raise notice 'valor %', distancia_paragrupoValor;
		end loop;

		---Colocando a distancia calculada na tabela
		update iris_versicolor set distancia_paragrupo = distancia_paragrupoValor where idi = i;
		distancia_paragrupoValor = 0;
		
	end loop;
	-----------------------------------------------------------------------
	
	----------------------> Iris-virginica <---------------------------------------
	select count(idi) into quantidade from iris_virginica;
	
	for i in 1..quantidade loop
		select * into pontoInicial from iris_virginica where idi = i;
		--raise notice 'pontoInicial %', pontoInicial;
		for j in 1..quantidade loop
			select * into pontoFinal from iris_virginica where idi = j;
			--raise notice 'valor %', pontoFinal.dados_eixo_w;
			distancia_paragrupoValor = (SQRT((pontoFinal.dados_eixo_w - pontoInicial.dados_eixo_w)^2 + 
			(pontoFinal.dados_eixo_x - pontoInicial.dados_eixo_x)^2 +
			(pontoFinal.dados_eixo_y - pontoInicial.dados_eixo_y)^2 +
			(pontoFinal.dados_eixo_z - pontoInicial.dados_eixo_z)^2) + distancia_paragrupoValor)/100
			;
			--raise notice 'valor %', distancia_paragrupoValor;
		end loop;
		---Colocando a distancia calculada na tabela
		update iris_virginica set distancia_paragrupo = distancia_paragrupoValor where idi = i;
		distancia_paragrupoValor = 0.0;
	end loop;
	--------------------------------------------------------------------------------------
	
	------Selecionando novo methoid do grupo "IRIS-SETOSA"------
	select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into Novomethoid from iris_setosa where distancia_paragrupo = 
	(select min(distancia_paragrupo) from iris_setosa);
	
	update medoids set w = Novomethoid.dados_eixo_w where medoids_id = 1;
	update medoids set x = Novomethoid.dados_eixo_x where medoids_id = 1;
	update medoids set y = Novomethoid.dados_eixo_y where medoids_id = 1;
	update medoids set z = Novomethoid.dados_eixo_z where medoids_id= 1;

	---------------------------------------------------------------
	------Selecionando novo methoid do grupo "IRIS-VERSICOLOR"------
	select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into Novomethoid from iris_versicolor where distancia_paragrupo = 
	(select min(distancia_paragrupo) from iris_versicolor);
	
	update medoids set w = Novomethoid.dados_eixo_w where medoids_id = 2;
	update medoids set x = Novomethoid.dados_eixo_x where medoids_id = 2;
	update medoids set y = Novomethoid.dados_eixo_y where medoids_id = 2;
	update medoids set z = Novomethoid.dados_eixo_z where medoids_id= 2;

	---------------------------------------------------------------------------------------------
	------Selecionando novo methoid do grupo "IRIS-VIRGINICA"------
	select dados_eixo_w, dados_eixo_x,  dados_eixo_y,  dados_eixo_z into Novomethoid from iris_virginica where distancia_paragrupo = 
	(select min(distancia_paragrupo) from iris_virginica);
	
	update medoids set w = Novomethoid.dados_eixo_w where medoids_id = 3;
	update medoids set x = Novomethoid.dados_eixo_x where medoids_id = 3;
	update medoids set y = Novomethoid.dados_eixo_y where medoids_id = 3;
	update medoids set z = Novomethoid.dados_eixo_z where medoids_id= 3;


	return 'Executado com sucesso';
end
$$ language plpgsql;