-- #449728 - Ocorrências de Presencialidade

INSERT INTO financeiro.parametros_rubrica (id_parametros_rubrica, nome, descricao, valor) 
VALUES(nextval('financeiro.parametros_rubrica_seq'), 'RUBRICAS_ARQUIVO_OCORRENCIA_PRESENCIALIDADE', 
'Ids que identificam as rubricas que os servidores devem receber para serem enviados no arquivo de presencialidade.', '');