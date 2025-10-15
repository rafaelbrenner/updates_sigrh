--#437096 - Desenvolvimento Tela Relatório Evasão
ALTER TABLE capacitacao.formulario_evasao_turma ADD COLUMN avaliacao_chefia boolean DEFAULT false;
COMMENT ON COLUMN capacitacao.formulario_evasao_turma.avaliacao_chefia IS 'Indica se a avaliação foi realizada pela chefia.';
