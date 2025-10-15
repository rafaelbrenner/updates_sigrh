-- #406411 - Atualização de Validade de Créditos de Horas

/**
 
Observações:

1. Rodar apenas após a aplicação do script de migration da tarefa #406411.
2. Rodar apenas se não for possível alterar o parâmetro "TIPO DE CÁLCULO DA VIGÊNCIA DO CRÉDITO DE HORAS MENSAL" via sistema para a data desejada devido a folhas de ponto já homologadas no período.

O script abaixo realiza o seguinte procedimento:
1. Encerra o cálculo de vigência dos bancos de horas de quantidade de meses fixas em Nov/2023 (cálculo aplicado atualmente)
2. Atribui o novo cálculo de vigência dos bancos de horas até o término do ano civil subsequente a partir de Dez/2023.
3. Atualiza a validade dos bancos de horas, referentes às folhas de ponto a partir de Dez/2023, para o dia 31/12 do ano civil subsequente ao ano da folha de ponto. 

*/


-- 1. Encerra o cálculo ANTIGO (que considera a vigência dos bancos por uma quantidade de meses consecutivos) em 30/11/2023 (cálculo aplicado às folhas de ponto até Nov/2023).
UPDATE frequencia.parametros_ponto_vigencia SET data_termino = '2023-11-30' WHERE data_inicio IS NULL AND data_termino IS NULL AND id_parametro_ponto IN (
	SELECT id_parametro_ponto FROM frequencia.parametros_ponto WHERE nome = 'TIPO_CALCULO_VIGENCIA_BANCO_HORAS'
);

-- 2. Inicia o cálculo NOVO em 01/12/2023 (cálculo aplicado às folhas de ponto a partir de Dez/2023).
INSERT INTO frequencia.parametros_ponto_vigencia 
SELECT nextval('frequencia.parametros_ponto_vigencia_seq'), id_parametro_ponto, '2023-12-01', null, 'EXERCICIO_CIVIL_SUBSEQUENTE' FROM frequencia.parametros_ponto WHERE nome = 'TIPO_CALCULO_VIGENCIA_BANCO_HORAS';

-- 3. Atualiza a data de expiração dos bancos em 31/12 do ano subsequente ao ano da folha de ponto homologada (aplicado a todas as folhas de mês/ano a partir do início da vigência do novo cálculo).
UPDATE frequencia.banco_horas_servidor SET data_termino_consumo = make_date(YEAR(data_inicio_consumo - INTERVAL '1 month') + 1, 12, 31) WHERE data_inicio_consumo > (
	SELECT max(data_inicio) FROM frequencia.parametros_ponto_vigencia ppv WHERE valor = 'EXERCICIO_CIVIL_SUBSEQUENTE'
);
