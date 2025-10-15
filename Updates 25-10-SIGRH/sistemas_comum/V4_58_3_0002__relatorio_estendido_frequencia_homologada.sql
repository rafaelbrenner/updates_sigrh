--#442393 - Melhorias no relatório de Frequências já Homologadas (Corrigido)

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo, tempo_maximo, tipo, padrao, valor_minimo, valor_maximo) 
VALUES 
    ('REL_FREQUENCIAS_HOMOLOGADAS_ESTENDIDO',
     'Se o valor for true, ativará o modo estendido do relatório de frequências já homologadas, isso , além dos servidores cuja frequência foi homologada na unidade buscada, ele mostrará também os servidores com designação em tal unidade, bem como os servidores lotados ou em exercício nela, mas que tiveram suas frequências homologadas em outra unidade. Se o valor for false, o relatório mostrará apenas as frequências homologadas na unidade buscada.',
     'false', 101600, 7, '7_101600_20', NULL, 16, NULL, NULL, NULL)
ON CONFLICT (codigo) DO NOTHING;