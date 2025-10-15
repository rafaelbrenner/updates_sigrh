--#449448 - Impedir ou não que servidores de férias de registrem ponto eletrônico conforme configuração de parâmetro - Colaboração UFRRJ

INSERT INTO frequencia.parametros_ponto (id_parametro_ponto, nome, descricao, valor_old, obrigatorio, tipo_valor_parametro, nome_exibicao, contexto_parametro) VALUES ( (select nextval('frequencia.parametros_ponto_seq')), 'BLOQUEIA_ENTRADA_SERVIDOR_FERIAS', 'Define se um servidor de férias deverá ser impedido de registrar sua entrada no ponto eletrônico ou não', false, true, 'LOGICO', 'Impedir que servidores de férias registrem entrada no ponto eletrônico', 'CONFIGURACAO_GERAL' ); 

-- UFRN
INSERT INTO frequencia.parametros_ponto_vigencia (id_parametros_ponto_vigencia, id_parametro_ponto, valor) VALUES ( (select nextval('frequencia.parametros_ponto_vigencia_seq')), (SELECT id_parametro_ponto FROM frequencia.parametros_ponto WHERE nome = 'BLOQUEIA_ENTRADA_SERVIDOR_FERIAS'), false );
--
