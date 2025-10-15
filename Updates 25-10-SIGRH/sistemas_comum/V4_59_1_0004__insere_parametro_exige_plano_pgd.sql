-- #453605 - Adiciona regra ocorrências PDG.

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo)
VALUES ('EXIGE_PLANO_POLARE_OCORRENCIAS_PGD',
'Indica se há exigência de cadastro prévio do plano de trabalho do servidor junto ao sistema Polare, para as ocorrências pertencentes ao grupo PGD.',
'false', 100500, 7, '7_100500_20', NULL, 16, NULL, NULL, NULL);
