-- #451270 - Criar papel "ATUALIZADOR NOME SOCIAL" no SIGRH

-- Inserção do papel ATUALIZADOR NOME SOCIAL.
INSERT INTO comum.papel (id, id_sistema, id_subsistema, descricao, restrito, exige_unidade, nome, tipo_autorizacao, tempo_alteracao_senha, sql_filtro_unidades) 
VALUES(101903, 7, 101900, 'Permite o usuário a realizar atualização do nome social dos servidores através do cadastro de dados complementares existente no módulo de cadastros.', false, false, 'ATUALIZADOR NOME SOCIAL', 1, NULL, NULL);


-- Inserção do parâmetro para limitar que o nome social seja atualizado apenas pelos usuários com papel de ATUALIZADOR NOME SOCIAL.
INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo) 
VALUES('LIMITAR_ATUALIZACAO_NOME_SOCIAL_AO_PAPEL_ATUALIZADOR_NOME_SOCIAL', 'Define se o nome social dos servidores pode ser editado apenas por quem possuir papel "ATUALIZADOR NOME SOCIAL".', 
'false', 101900, 7, '7_101900_2', NULL, NULL, NULL, NULL, NULL);