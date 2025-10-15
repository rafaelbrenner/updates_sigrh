--#434155 - Adaptar o SIGRH para nгo usar o valor idInstituicao de "Dados Institucionais".

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo) 
VALUES('ID_INSTITUICAO_ATUAL', 'Indica o id desta instituição na tabela administrativo.funcional.instituicao', 
(SELECT valor FROM comum.dados_institucionais WHERE nome = 'idInstituicao'), 100100, 7, '7_100100_1008', NULL, NULL, NULL, NULL, NULL);