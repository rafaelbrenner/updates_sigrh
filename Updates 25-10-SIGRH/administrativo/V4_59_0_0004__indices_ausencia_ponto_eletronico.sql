-- #450167 - Otimização na busca de ausências usada no cálculo do ponto eletrônico.

CREATE INDEX IF NOT EXISTS idx_ausencia_servidor_status_data ON funcional.ausencia(id_servidor,id_status_ausencia,inicio,fim,termino_real);
CREATE INDEX IF NOT EXISTS idx_aut_comp_id_ausencia_data ON frequencia.autorizacao_compensacao_debito(id_ausencia, data_inicio, data_termino);
CREATE INDEX IF NOT EXISTS idx_util_banco_id_ausencia ON frequencia.utilizacao_banco_horas(id_ausencia);

-- Índice parcial para acelerar a CTE historico_atualizacao
CREATE INDEX IF NOT EXISTS idx_he_ausencia_obs_data
  ON comum.historico_entidade(id_entidade, data_operacao)
  WHERE classe_entidade = 'br.ufrn.sigrh.funcional.dominio.Ausencia'
    AND observacoes IN ('CADASTRO DA AUSÊNCIA', 'ALTERAÇÃO DA AUSÊNCIA');
--
---- Índice para a subquery de banco de horas
CREATE INDEX IF NOT EXISTS idx_ubh_id_banco_ausencia
  ON frequencia.utilizacao_banco_horas(id_banco_horas_servidor, id_ausencia)
  WHERE id_ausencia IS NOT NULL;
 
CREATE INDEX IF NOT EXISTS idx_he_entidade_data_desc
  ON comum.historico_entidade(id_entidade, data_operacao DESC)
  WHERE classe_entidade = 'br.ufrn.sigrh.funcional.dominio.Ausencia'
    AND observacoes IN ('CADASTRO DA AUSÊNCIA', 'ALTERAÇÃO DA AUSÊNCIA');