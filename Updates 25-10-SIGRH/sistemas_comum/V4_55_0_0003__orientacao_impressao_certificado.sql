 -- #387150 - Ajuste na emissão de certificados de capacitação.

--INSERT INTO comum.parametro (nome,descricao,valor,id_subsistema,id_sistema,codigo,tempo_maximo,tipo,padrao,valor_minimo,valor_maximo) 
--VALUES ('ORIENTACAO_IMPRESSAO_CERTIFICADO','Define quais serão as orientações possíveis para impressão de certificados de capacitação: R (retrato), P (paisagem), ou A (ambos.)','A',101200,7,'7_101200_474',NULL,12,'^(R|r|P|p|A|a){1}$',NULL,NULL);