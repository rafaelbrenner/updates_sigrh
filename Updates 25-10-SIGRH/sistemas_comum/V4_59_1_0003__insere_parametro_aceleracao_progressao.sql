--#451772 - Correção Aceleração de Progressão por Capacitação

UPDATE comum.parametro SET descricao = replace(descricao, 'MP 1286/2024', 'Lei Nº 15.141/2025') WHERE codigo IN ('7_100100_349', '7_100100_350', '7_100100_351', '7_100100_283');

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo) 
VALUES ('NUMERO_MAXIMO_ACELERACAO_PROGRESSAO', 'Indica a quantidade máxima de acelerações de progressão por capacitação que pode ser obtida pelo servidor.', 3, 100100, 7, '7_100100_352');

