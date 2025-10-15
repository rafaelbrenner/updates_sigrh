--#380242 - Melhorias no relatório de Frequências já Homologadas.

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo) 
VALUES 
    ('REL_FREQUENCIAS_HOMOLOGADAS_ESTENDIDO',
     'Se o valor for true, ativar o modo estendido do relatrio de frequncias já homologadas, isso , alm dos servidores cuja frequncia foi homologada na unidade buscada, ele mostrar tambm os servidores com designao em tal unidade, bem como os servidores lotados ou em exerccio nela, mas que tiveram suas frequncias homologadas em outra unidade. Se o valor for false, o relatrio mostrar apenas as frequncias homologadas na unidade buscada.',
     'false', 101600, 7, '7_101600_20', NULL, 16, NULL, NULL, NULL)
ON CONFLICT (codigo) DO NOTHING;
