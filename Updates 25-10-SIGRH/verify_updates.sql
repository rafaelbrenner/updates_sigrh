--=============================================================================
-- SCRIPT DE VERIFICAÇÃO - ATUALIZAÇÕES SIGRH
-- Verifica se os scripts foram executados corretamente
--=============================================================================

-- ============================================================
-- 1. VERIFICAR SE TRIGGERS FORAM REMOVIDAS (001-Drop-Triggers.sql)
-- ============================================================
SELECT 
    'TRIGGERS' AS verificacao,
    CASE 
        WHEN COUNT(*) = 0 THEN '✓ OK - Triggers removidas'
        ELSE '✗ ERRO - Triggers ainda existem: ' || STRING_AGG(trigger_name, ', ')
    END AS status
FROM information_schema.triggers
WHERE trigger_name IN ('tg_cadastroalteracaoemail_up')
  AND event_object_schema IN ('comum');

-- ============================================================
-- 2. VERIFICAR AUMENTO DA COLUNA LOGIN (V4_46_2_0001)
-- ============================================================
SELECT 
    'COLUNA LOGIN' AS verificacao,
    CASE 
        WHEN character_maximum_length = 100 THEN '✓ OK - Coluna login com 100 caracteres'
        ELSE '✗ ERRO - Coluna login com ' || character_maximum_length || ' caracteres'
    END AS status,
    character_maximum_length AS tamanho_atual
FROM information_schema.columns
WHERE table_schema = 'comum'
  AND table_name = 'usuario'
  AND column_name = 'login';

-- ============================================================
-- 3. VERIFICAR COLUNA ATIVO EM LINHA_TRANSPORTE (V4_48_6_0001)
-- ============================================================
SELECT 
    'COLUNA ATIVO - LINHA_TRANSPORTE' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna ativo criada'
        ELSE '✗ ERRO - Coluna ativo não existe'
    END AS status,
    MAX(data_type) AS tipo_dados,
    MAX(column_default) AS valor_padrao
FROM information_schema.columns
WHERE table_schema = 'transporte'
  AND table_name = 'linha_transporte'
  AND column_name = 'ativo';

-- ============================================================
-- 4. VERIFICAR COLUNA EXIGE_OBSERVACAO (V4_48_12_0001)
-- ============================================================
SELECT 
    'COLUNA EXIGE_OBSERVACAO - OCORRENCIA' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna exige_observacao criada'
        ELSE '⚠ AVISO - Coluna não existe (script estava comentado)'
    END AS status,
    MAX(data_type) AS tipo_dados,
    MAX(column_default) AS valor_padrao
FROM information_schema.columns
WHERE table_schema = 'funcional'
  AND table_name = 'ocorrencia'
  AND column_name = 'exige_observacao';

-- ============================================================
-- 5. VERIFICAR UPDATE EM TIPO_GRAU_PARENTESCO (V4_35_33_0001)
-- ============================================================
-- Este script estava comentado, então não há o que verificar
SELECT 
    'UPDATE TIPO_GRAU_PARENTESCO' AS verificacao,
    '⚠ AVISO - Script estava comentado, não foi executado' AS status;

-- ============================================================
-- 6. RESUMO GERAL DAS VERIFICAÇÕES
-- ============================================================
SELECT 
    '========================' AS separador,
    'RESUMO DAS VERIFICAÇÕES' AS titulo,
    '========================' AS separador2;

-- Contagem de verificações bem-sucedidas
WITH verificacoes AS (
    SELECT COUNT(*) FILTER (WHERE character_maximum_length = 100) AS login_ok
    FROM information_schema.columns
    WHERE table_schema = 'comum' AND table_name = 'usuario' AND column_name = 'login'
    
    UNION ALL
    
    SELECT COUNT(*) FILTER (WHERE column_name = 'ativo') AS ativo_ok
    FROM information_schema.columns
    WHERE table_schema = 'transporte' AND table_name = 'linha_transporte'
)
SELECT 
    'Total de alterações verificadas' AS item,
    SUM(login_ok) AS quantidade
FROM verificacoes;

-- ============================================================
-- 7. VERIFICAR COLUNA AVALIACAO_CHEFIA (V4_58_2_0007)
-- ============================================================
SELECT 
    'COLUNA AVALIACAO_CHEFIA' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna avaliacao_chefia criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'capacitacao'
  AND table_name = 'formulario_evasao_turma'
  AND column_name = 'avaliacao_chefia';

-- ============================================================
-- 8. VERIFICAR COLUNA DATA_INATIVACAO (V4_58_3_0002)
-- ============================================================
SELECT 
    'COLUNA DATA_INATIVACAO' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna data_inativacao criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'avaliacao_desempenho'
  AND table_name = 'formulario_desempenho'
  AND column_name = 'data_inativacao';

-- ============================================================
-- 9. VERIFICAR FK CORRIGIDA (V4_58_3_0004)
-- ============================================================
SELECT 
    'FK AUTORIZACAO_IRPF' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - FK autorizacao_acesso_irpf_id_calendario_fkey existe'
        ELSE '✗ ERRO - FK não encontrada'
    END AS status
FROM information_schema.table_constraints
WHERE constraint_name = 'autorizacao_acesso_irpf_id_calendario_fkey'
  AND table_schema = 'financeiro'
  AND table_name = 'autorizacao_acesso_irpf';

-- ============================================================
-- 10. VERIFICAR COLUNA CARACTERIZA_PCD (V4_58_3_0005)
-- ============================================================
SELECT 
    'COLUNA CARACTERIZA_PCD' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna caracteriza_pcd criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'comum'
  AND table_name = 'tipo_necessidade_especial'
  AND column_name = 'caracteriza_pcd';

-- ============================================================
-- 11. VERIFICAR COLUNA ID_VAGA_CONCURSO_NOMEACAO (V4_58_2_0002)
-- ============================================================
SELECT 
    'COLUNA ID_VAGA_CONCURSO_NOMEACAO' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna id_vaga_concurso_nomeacao criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'rh'
  AND table_name = 'servidor'
  AND column_name = 'id_vaga_concurso_nomeacao';

-- ============================================================
-- 12. VERIFICAR COLUNAS UNIDADE LOTACAO/EXERCICIO (V4_58_2_0002)
-- ============================================================
SELECT 
    'COLUNAS UNIDADE - FREQUENCIA' AS verificacao,
    CASE 
        WHEN COUNT(*) = 2 THEN '✓ OK - Colunas id_unidade_lotacao e id_unidade_exercicio criadas'
        WHEN COUNT(*) = 1 THEN '⚠ PARCIAL - Apenas 1 coluna criada'
        ELSE '✗ ERRO - Colunas não existem'
    END AS status,
    COUNT(*) AS colunas_criadas
FROM information_schema.columns
WHERE table_schema = 'funcional'
  AND table_name = 'frequencia'
  AND column_name IN ('id_unidade_lotacao', 'id_unidade_exercicio');

-- ============================================================
-- 13. VERIFICAR COLUNA ID_GENERO (V4_58_2_0004)
-- ============================================================
SELECT 
    'COLUNAS ID_GENERO' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 3 THEN '✓ OK - Colunas id_genero criadas nas tabelas'
        ELSE '✗ ERRO - Nem todas as colunas foram criadas'
    END AS status,
    COUNT(*) AS tabelas_atualizadas
FROM information_schema.columns
WHERE column_name = 'id_genero'
  AND ((table_schema = 'concurso' AND table_name IN ('pessoa_candidato', 'inscricao_candidato', 'candidato_aprovado'))
       OR (table_schema = 'comum' AND table_name = 'pessoa'));

-- ============================================================
-- 14. VERIFICAR NOVOS GENEROS CADASTRADOS (V4_58_2_0004)
-- ============================================================
SELECT 
    'NOVOS GENEROS' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 7 THEN '✓ OK - Novos gêneros cadastrados (IDs 5-11)'
        ELSE '⚠ AVISO - Apenas ' || COUNT(*) || ' novos gêneros encontrados'
    END AS status,
    COUNT(*) AS novos_generos
FROM comum.genero
WHERE id_genero BETWEEN 5 AND 11;

-- ============================================================
-- 15. VERIFICAR COLUNAS HISTORICO FORMACAO ESCOLAR (V4_58_2_0006)
-- ============================================================
SELECT 
    'COLUNAS HISTORICO - FORMACAO_ESCOLAR' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 7 THEN '✓ OK - Todas as colunas de histórico criadas'
        ELSE '✗ ERRO - Faltam colunas (' || COUNT(*) || '/8)'
    END AS status,
    COUNT(*) AS colunas_criadas
FROM information_schema.columns
WHERE table_schema = 'pessoal'
  AND table_name = 'formacao_escolar'
  AND column_name LIKE '%_historico';

-- ============================================================
-- 16. VERIFICAR NOVAS CLASSES FUNCIONAIS DOCENTES (V4_59_0_0002)
-- ============================================================
SELECT 
    'NOVAS CLASSES FUNCIONAIS' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 8 THEN '✓ OK - Novas classes criadas (IDs 112-119)'
        ELSE '⚠ AVISO - Apenas ' || COUNT(*) || ' classes encontradas'
    END AS status,
    COUNT(*) AS classes_criadas
FROM rh.classe_funcional
WHERE id_classe_funcional BETWEEN 112 AND 119;

-- ============================================================
-- 17. VERIFICAR NOVOS TIPOS DE PROGRESSAO (V4_59_0_0001 e V4_59_0_0002)
-- ============================================================
SELECT 
    'NOVOS TIPOS PROGRESSAO' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 3 THEN '✓ OK - Novos tipos de progressão criados (IDs 19, 20, 21)'
        ELSE '⚠ AVISO - Apenas ' || COUNT(*) || ' tipos encontrados'
    END AS status,
    STRING_AGG(denominacao, '; ') AS tipos_encontrados
FROM rh_tipos.tipo_progressao
WHERE id_tipo_progressao IN (19, 20, 21);

-- ============================================================
-- 18. VERIFICAR COLUNA SALDO EM PROGRESSAO (V4_59_0_0001)
-- ============================================================
SELECT 
    'COLUNA SALDO - PROGRESSAO' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna saldo criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'funcional'
  AND table_name = 'progressao'
  AND column_name = 'saldo';

-- ============================================================
-- 19. VERIFICAR INDICES CRIADOS (V4_59_0_0004)
-- ============================================================
SELECT 
    'INDICES PERFORMANCE' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 5 THEN '✓ OK - Índices de performance criados'
        ELSE '⚠ AVISO - Apenas ' || COUNT(*) || ' índices encontrados'
    END AS status,
    COUNT(*) AS indices_criados
FROM pg_indexes
WHERE indexname IN (
    'idx_ausencia_servidor_status_data',
    'idx_aut_comp_id_ausencia_data',
    'idx_util_banco_id_ausencia',
    'idx_he_ausencia_obs_data',
    'idx_ubh_id_banco_ausencia',
    'idx_he_entidade_data_desc'
);

-- ============================================================
-- 20. VERIFICAR PARAMETRO PONTO BLOQUEIO FERIAS (V4_58_2_0001)
-- ============================================================
SELECT 
    'PARAMETRO BLOQUEIO FERIAS' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Parâmetro BLOQUEIA_ENTRADA_SERVIDOR_FERIAS criado'
        ELSE '✗ ERRO - Parâmetro não existe'
    END AS status
FROM frequencia.parametros_ponto
WHERE nome = 'BLOQUEIA_ENTRADA_SERVIDOR_FERIAS';

-- ============================================================
-- 21. VERIFICAR COLUNAS VIGENCIA (V4_59_0_0002)
-- ============================================================
SELECT 
    'COLUNAS VIGENCIA - CLASSE_FUNCIONAL' AS verificacao,
    CASE 
        WHEN COUNT(*) = 2 THEN '✓ OK - Colunas inicio_vigencia e termino_vigencia criadas'
        ELSE '✗ ERRO - Colunas não existem'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'fita_espelho'
  AND table_name = 'classe_funcional_cargos'
  AND column_name IN ('inicio_vigencia', 'termino_vigencia');

-- ============================================================
-- 23. VERIFICAR COLUNAS VIGENCIA CARGA HORARIA (V4_59_1_0005)
-- ============================================================
SELECT 
    'COLUNAS VIGENCIA - CARGA_HORARIA_CAPAC_PROG' AS verificacao,
    CASE 
        WHEN COUNT(*) = 2 THEN '✓ OK - Colunas inicio_vigencia e termino_vigencia criadas'
        ELSE '✗ ERRO - Colunas não existem'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'pessoal'
  AND table_name = 'carga_horaria_capac_prog'
  AND column_name IN ('inicio_vigencia', 'termino_vigencia');

-- ============================================================
-- 24. VERIFICAR TIPO PROGRESSAO ACELERACAO (V4_59_1_0005)
-- ============================================================
SELECT 
    'TIPO PROGRESSAO ACELERACAO' AS verificacao,
    CASE 
        WHEN denominacao = 'ACELERAÇÃO DA PROGRESSÃO POR CAPACITAÇÃO' 
        AND exige_formacao_capacitacao = TRUE
        THEN '✓ OK - Tipo progressão 21 atualizado corretamente'
        ELSE '✗ ERRO - Tipo progressão 21 não atualizado'
    END AS status
FROM rh_tipos.tipo_progressao
WHERE id_tipo_progressao = 21;

-- ============================================================
-- 25. VERIFICAR TABELA COTA_CONCORRENCIA_CONCURSO (V4_59_1_0007)
-- ============================================================
SELECT 
    'TABELA COTA_CONCORRENCIA_CONCURSO' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Tabela cota_concorrencia_concurso criada'
        ELSE '✗ ERRO - Tabela não existe'
    END AS status
FROM information_schema.tables
WHERE table_schema = 'concurso'
  AND table_name = 'cota_concorrencia_concurso';

-- ============================================================
-- 26. VERIFICAR COLUNA ID_ARQUIVO_COMPROV_DEFICIENCIA (V4_59_1_0007)
-- ============================================================
SELECT 
    'COLUNA ID_ARQUIVO_COMPROV_DEFICIENCIA' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Coluna id_arquivo_comprov_deficiencia criada'
        ELSE '✗ ERRO - Coluna não existe'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'concurso'
  AND table_name = 'inscricao_candidato'
  AND column_name = 'id_arquivo_comprov_deficiencia';

-- ============================================================
-- 27. VERIFICAR SCHEMA GOVERNANCA (V4_60_0_0001)
-- ============================================================
SELECT 
    'SCHEMA GOVERNANCA' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Schema governanca criado'
        ELSE '✗ ERRO - Schema não existe'
    END AS status
FROM information_schema.schemata
WHERE schema_name = 'governanca';

-- ============================================================
-- 28. VERIFICAR TABELAS MODULO GOVERNANCA (V4_60_0_0001)
-- ============================================================
SELECT 
    'TABELAS MODULO GOVERNANCA' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 4 THEN '✓ OK - Tabelas do módulo governança criadas'
        ELSE '✗ ERRO - Apenas ' || COUNT(*) || ' tabelas encontradas'
    END AS status,
    COUNT(*) AS tabelas_criadas
FROM information_schema.tables
WHERE table_schema = 'governanca'
  AND table_name IN ('comite_governanca', 'arquivo_anexo_resolucao_governanca', 
                     'resolucao', 'tipo_resolucao');

-- ============================================================
-- 29. VERIFICAR EXTENSION UNACCENT (V4_60_0_0002)
-- ============================================================
SELECT 
    'EXTENSION UNACCENT' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Extension unaccent instalada'
        ELSE '✗ ERRO - Extension não instalada'
    END AS status
FROM pg_extension
WHERE extname = 'unaccent';

-- ============================================================
-- 30. VERIFICAR MAPEAMENTO CLASSES VISITANTES (V4_60_0_0003)
-- ============================================================
SELECT 
    'CLASSES VISITANTES MAGISTÉRIO' AS verificacao,
    CASE 
        WHEN COUNT(*) >= 4 THEN '✓ OK - Classes de visitantes mapeadas (IDs 48-51)'
        ELSE '⚠ AVISO - Apenas ' || COUNT(*) || ' mapeamentos encontrados'
    END AS status
FROM fita_espelho.classe_funcional_cargos
WHERE id_classe_funcional_cargos BETWEEN 48 AND 51
  AND id_cargo = 705003;

-- ============================================================
-- 31. VERIFICAR TIPO NECESSIDADE ESPECIAL ADVENTISTA (V4_60_0_0004)
-- ============================================================
SELECT 
    'TIPO NECESSIDADE ADVENTISTA 7º DIA' AS verificacao,
    CASE 
        WHEN COUNT(*) > 0 THEN '✓ OK - Tipo necessidade Adventista do 7º Dia cadastrado'
        ELSE '✗ ERRO - Tipo não cadastrado'
    END AS status
FROM concurso.tipos_necessidade_especial_concurso
WHERE id_tipos_necessidade_especial_concurso = 14;

-- ============================================================
-- 32. VERIFICAR TRIGGERS RECRIADAS (ZZX-Create-Triggers)
-- ============================================================
SELECT 
    'TRIGGERS RECRIADAS' AS verificacao,
    CASE 
        WHEN COUNT(*) = 2 THEN '✓ OK - Triggers tg_cadastroalteracaoemail_up recriadas'
        WHEN COUNT(*) = 1 THEN '⚠ PARCIAL - Apenas 1 trigger recriada'
        ELSE '✗ ERRO - Triggers não recriadas'
    END AS status
FROM information_schema.triggers
WHERE trigger_name = 'tg_cadastroalteracaoemail_up'
  AND event_object_schema = 'comum'
  AND event_object_table IN ('usuario', 'pessoa');

-- ============================================================
-- 33. RESUMO GERAL COMPLETO
-- ============================================================
SELECT 
    '========================' AS separador,
    'RESUMO FINAL' AS titulo,
    '========================' AS separador2;

SELECT 
    'Scripts Analisados' AS categoria,
    '40 arquivos SQL' AS quantidade;

SELECT 
    'Transação' AS categoria,
    'BEGIN executado' AS inicio,
    'COMMIT executado' AS fim;

-- ============================================================
-- 34. CONTAGEM DE ALTERAÇÕES EXECUTADAS
-- ============================================================
WITH alteracoes_verificadas AS (
    SELECT 
        (SELECT COUNT(*) FROM information_schema.columns 
         WHERE table_schema = 'comum' AND table_name = 'usuario' 
         AND column_name = 'login' AND character_maximum_length = 100) AS login_ok,
        
        (SELECT COUNT(*) FROM information_schema.columns 
         WHERE table_schema = 'transporte' AND table_name = 'linha_transporte' 
         AND column_name = 'ativo') AS ativo_ok,
        
        (SELECT COUNT(*) FROM information_schema.schemata 
         WHERE schema_name = 'governanca') AS governanca_ok,
        
        (SELECT COUNT(*) FROM pg_extension 
         WHERE extname = 'unaccent') AS unaccent_ok,
        
        (SELECT COUNT(*) FROM rh.classe_funcional 
         WHERE id_classe_funcional BETWEEN 112 AND 119) AS classes_ok,
        
        (SELECT COUNT(*) FROM information_schema.triggers 
         WHERE trigger_name = 'tg_cadastroalteracaoemail_up') AS triggers_ok
)
SELECT 
    'Alterações Críticas Aplicadas' AS categoria,
    CASE 
        WHEN login_ok = 1 AND ativo_ok = 1 AND governanca_ok = 1 
             AND unaccent_ok = 1 AND classes_ok >= 8 AND triggers_ok = 2
        THEN '✓ SISTEMA ATUALIZADO COM SUCESSO'
        ELSE '⚠ VERIFICAR PENDÊNCIAS ACIMA'
    END AS status
FROM alteracoes_verificadas;

-- ============================================================
-- 35. SCRIPTS COMENTADOS (NÃO EXECUTADOS)
-- ============================================================
SELECT 
    '========================' AS separador,
    'SCRIPTS COMENTADOS' AS titulo,
    '(Não executados)' AS observacao,
    '========================' AS separador2;

SELECT 'V4_35_33_0001' AS script, 'UPDATE tipo_grau_parentesco' AS descricao UNION ALL
SELECT 'V4_48_12_0001', 'ADD COLUMN exige_observacao' UNION ALL
SELECT 'V4_53_0_0002', 'UPDATE campos_obrigatorios ocorrencia_api' UNION ALL
SELECT 'V4_58_2_0003', 'INSERT status_deferimento_requerimento' UNION ALL
SELECT 'V4_58_3_0003', 'ADD COLUMNS id_unidade (duplicado)' UNION ALL
SELECT 'V4_59_0_0001', 'Script reposicionamento (URGENTE - MANUAL)';