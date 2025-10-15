--#351846 - Impedir a homologação de férias por chefe ausente
--INSERT INTO comum.parametro (nome,descricao,valor,id_subsistema,id_sistema,codigo,tempo_maximo,tipo,padrao,valor_minimo,valor_maximo) VALUES  ('PERMITIR_CHEFE_AUSENTE_HOMOLOGAR_FERIAS','Se o valor for true, mesmo que os gestores da respectiva unidade estejam ausentes, os mesmos poderam realizar a homologação de férias.','true',101500,7,'7_101500_16',NULL,NULL,NULL,NULL,NULL);

--INSERT INTO comum.mensagem_aviso VALUES ('7_100100_137', 'Chefes com ausência vigente não podem homologar férias.',7, 100100, 0, 'br.ufrn.sigrh.mensagens.MensagensDap');
