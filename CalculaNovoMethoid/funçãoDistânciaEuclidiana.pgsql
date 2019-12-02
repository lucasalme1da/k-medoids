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
		SELECT count(dados_id) INTO quantidade FROM dados;
		-- Contando numero de medoids em 'medoids'
		SELECT count(w) INTO quantidade_medoids FROM medoids;

		--LOOP EXTERNO PERCORRE TODOS DADOS 
		FOR i IN 1..quantidade LOOP
			--PEGANDO VALORES DOS DADOS
			SELECT * into tuplaDADOS from dados where dados_id = i;
			--LOOP SOBRE OS METHOIDS
			FOR j IN 1..quantidade_medoids LOOP
				
				SELECT * into tuplaMETHOID from medoids where medoids_id = j;			

				valor_distancia = SQRT(POWER(tuplaMETHOID.w - tuplaDADOS.dados_eixo_w,2) + POWER(tuplaMETHOID.x - tuplaDADOS.dados_eixo_x,2) + POWER(tuplaMETHOID.y - tuplaDADOS.dados_eixo_y,2) + POWER(tuplaMETHOID.z - tuplaDADOS.dados_eixo_z,2));
				--raise notice 'VALOR DISTANCIA % -> %', j,valor_distancia;

				-- VERIFICANDO QUAL METHOIDS VAI CONQUISTAR O DADO
				if (menor_distancia = 0.0)then
					menor_distancia = valor_distancia;
					update dados set grupo_id = j where dados_id = i;
					CONTINUE;
				end if;
				
				if (valor_distancia < menor_distancia)then
					menor_distancia = valor_distancia;
					update dados set grupo_id = j where dados_id = i;
				end if;

			END LOOP;
			menor_distancia = 0.0;
		END LOOP;
		RETURN 'Executado com sucesso!';
		--RAISE NOTICE 'Quantidade de valores teoricos -> %', quantidade_valores_teoricos;
	END;
$$ language plpgsql;