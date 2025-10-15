 -- #387150 - Ajuste na emissão de certificados de capacitação.

--INSERT INTO comum.parametro (nome,descricao,valor,id_subsistema,id_sistema,codigo,tempo_maximo,tipo,padrao,valor_minimo,valor_maximo) 
--VALUES ('USAR_SEMPRE_CPF_CERTIFICADO_SERVIDOR','Caso esteja true, ao se emitir um certificado de curso de capacitação para um servidor, o documento de identificação será o CPF. Caso esteja false, a matrícula SIAPE será esse documento. Em ambos casos, não-servidores continuam a ser identificados pelo CPF.','false',101200,7,'7_101200_473',NULL,16,NULL,NULL,NULL);