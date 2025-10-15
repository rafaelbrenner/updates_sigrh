--#433253 - Reset do formulário de avaliação de desempenho
ALTER TABLE avaliacao_desempenho.formulario_desempenho
ADD COLUMN IF NOT EXISTS data_inativacao TIMESTAMP;
COMMENT ON COLUMN avaliacao_desempenho.formulario_desempenho.data_inativacao is 'Data/hora de inativação de um formulário';