-- #437797 - CONTROLE DE NOMEAÇAO

ALTER TABLE rh.servidor ADD IF NOT EXISTS id_vaga_concurso_nomeacao int4 NULL;
COMMENT ON COLUMN rh.servidor.id_vaga_concurso_nomeacao IS 'Vaga do concurso na qual o servidor foi nomeado.';
ALTER TABLE rh.servidor ADD CONSTRAINT servidor_vaga_concurso_nomeacao_fk FOREIGN KEY (id_vaga_concurso_nomeacao) REFERENCES concurso.vaga_concurso(id_vaga_concurso);

ALTER TABLE rh.servidor ADD IF NOT EXISTS tipo_concorrencia varchar(50) NULL;
COMMENT ON COLUMN rh.servidor.tipo_concorrencia IS 'Tipo de concorrência em que o servidor foi nomeado.';