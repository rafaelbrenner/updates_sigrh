-- #453439 - Criação do módulo governança

INSERT INTO comum.subsistema
(id, id_sistema, nome, link_entrada, nome_reduzido, ativo)
VALUES(102900, 7, 'Menu Governança', '/sigrh/governanca/menu_governanca.jsf', NULL, true);

INSERT INTO comum.papel
(id, id_sistema, id_subsistema, descricao, restrito, exige_unidade, nome, tipo_autorizacao, tempo_alteracao_senha, sql_filtro_unidades)
VALUES(102901, 7, 102900, 'Habilita o usuário a acessar o módulo de governança.', false, false, 'GESTOR_GOVERNANCA', 1, NULL, NULL);