-- #449443 - Atualizar versão de EntidadesComuns com parametrização de data base de GRU

INSERT INTO comum.parametro (nome, descricao, valor, id_sistema, codigo)
VALUES('DATA_BASE_GRU', 'Indica a data base a ser usada na geração do código de barras das GRUs cobrança.', '2022-05-29', 3, '3_0_17') ON CONFLICT DO NOTHING;
