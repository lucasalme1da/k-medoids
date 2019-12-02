CREATE TABLE medoids (
    w numeric(3,1),
	x numeric(3,1),
	y numeric(3,1),
	z numeric(3,1),
    medoids_id SERIAL --Grupo no qual o medoids representa
);

CREATE OR REPLACE FUNCTION selecionar_k_medoids_iniciais(k INTEGER)
	RETURNS text AS $$
	DECLARE
		reg medoids%rowtype;
		N INTEGER;
	BEGIN	
		SELECT INTO N COUNT(*) FROM dados; -- Conta numero de tuplas em valoresTeoricos
		DELETE FROM medoids; -- Limpa a tabela de medoids atuais
		-- Insere w,x,y,z da tabela valoresTeoricos k vezes na tabela medoids:
      	INSERT INTO medoids SELECT dados_eixo_w, dados_eixo_x, dados_eixo_y, dados_eixo_z FROM dados OFFSET floor(random()*N) LIMIT k;
		RETURN 'Executado com sucesso!';
	END;
$$ language plpgsql;

SELECT * FROM selecionar_k_medoids_iniciais(3);

-- Verificando medoids escolhidos
SELECT * FROM medoids;
