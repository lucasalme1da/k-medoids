create table dados(
    dados_id SERIAL,
    dados_eixo_w NUMERIC(3,1),
    dados_eixo_x NUMERIC(3,1),
    dados_eixo_y NUMERIC(3,1),
    dados_eixo_z NUMERIC(3,1),
    grupo_id integer, --Grupo no qual vai pertencer
    CONSTRAINT pkDados PRIMARY KEY (dados_id)
);

create table grupo(
    grupo_id integer,
    grupo_nome text,
    grupo_k_methoid integer,
    constraint pkGrupo primary key (grupo_id)
);