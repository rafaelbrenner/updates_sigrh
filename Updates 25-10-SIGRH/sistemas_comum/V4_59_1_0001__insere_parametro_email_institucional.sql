--#450551 - Ajusta exibição de e-mail institucional.

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo) 
VALUES ('UTILIZA_EMAIL_INSTITUCIONAL',
     'Indica a utilização dos e-mails institucionais junto ao SIGRH.',
     'false', 100500, 7, '7_100500_19', NULL, 16, NULL, NULL, NULL);
