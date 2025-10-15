-- #451772 - Correção Aceleração de Progressão por Capacitação

UPDATE funcional.factory_regras_progressao SET ids_tipo_progressao = '.6.21.' WHERE id_factory_regras_progressao = 10;
UPDATE rh_tipos.tipo_progressao SET exige_formacao_capacitacao = TRUE, denominacao = 'ACELERAÇÃO DA PROGRESSÃO POR CAPACITAÇÃO'  WHERE id_tipo_progressao = 21;

ALTER TABLE pessoal.carga_horaria_capac_prog ADD COLUMN inicio_vigencia date;
ALTER TABLE pessoal.carga_horaria_capac_prog ADD COLUMN termino_vigencia date;

COMMENT ON COLUMN pessoal.carga_horaria_capac_prog.inicio_vigencia IS 'Data de início da vigência desta carga horária mínima de capacitação para progressão do servidor.';
COMMENT ON COLUMN pessoal.carga_horaria_capac_prog.termino_vigencia IS 'Data de término da vigência desta carga horária mínima de capacitação para progressão do servidor.';
COMMENT ON COLUMN pessoal.carga_horaria_capac_prog.nivel_capacitacao IS 'Nível da Capacitação a ser obtido através da progressão (até 31/12/2024) ou quantidade de aclereções da progressão obtidas de uma única vez.';

UPDATE pessoal.carga_horaria_capac_prog SET termino_vigencia = '2024-12-31';

CREATE SEQUENCE pessoal.carga_horaria_capac_prog_seq;
ALTER SEQUENCE pessoal.carga_horaria_capac_prog_seq OWNER TO adm_group;

SELECT setval('pessoal.carga_horaria_capac_prog_seq', (SELECT max(id_carga_horaria_capac_prog) FROM pessoal.carga_horaria_capac_prog), TRUE);

INSERT INTO pessoal.carga_horaria_capac_prog
SELECT DISTINCT nextval('pessoal.carga_horaria_capac_prog_seq'), chcp.id_classe_funcional, 
chcp.carga_horaria * niveis.nivel_vertical, niveis.nivel_vertical, CAST('2025-01-01' AS date), CAST(null AS date)
FROM pessoal.carga_horaria_capac_prog chcp
INNER JOIN (
	SELECT 1 AS nivel_vertical UNION
	SELECT 2 AS nivel_vertical UNION 
	SELECT 3 AS nivel_vertical
) AS niveis ON (1 = 1)
WHERE nivel_capacitacao = 3
ORDER BY chcp.id_classe_funcional, niveis.nivel_vertical;


UPDATE capacitacao.finalidade_emissao_certificado SET descricao = 'Carga Horária para Progressão' WHERE id_finalidade_emissao = 1;

comment on column pessoal.formacao_escolar.id_tipo_incentivo_historico is 'Identicador do tipo de incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.inicio_incentivo_historico is 'Data de início do incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.processo_de_concessao_historico is 'Processo de concessão do incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.certificado_pendente_historico is 'Indica se há certificado pendente no incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.percentual_historico is 'Percentual do incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.termino_incentivo_historico is 'Data de término do incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.id_status_incentivo_historico is 'Identicador do status do incentivo cadastrado na formação antes da alteração relacionada à Lei Nº 15.141/2025.';
comment on column pessoal.formacao_escolar.observacao_historico is 'Observação cadastrada na formação antes da alteração relacionada à Lei Nº 15.141/2025.';

-- Atualização das observações dos incentivos inseridos via script
UPDATE pessoal.formacao_escolar SET observacao = 'Alteração realizada automaticamente via sistema, relacionada à Lei Nº 15.141/2025.' WHERE 
observacao = 'Alteração realizada automaticamente via sistema, relacionada à Medida Provisória 1286/2024.';

UPDATE rh_tipos.tipo_progressao SET denominacao = 'Reposicionamento na Carreira - Lei Nº 15.141/2025', denominacao_declaracao = 'Reposicionamento da Carreira conforme a Lei Nº 15.141/2025' WHERE id_tipo_progressao = 19;
UPDATE rh_tipos.tipo_progressao SET denominacao = 'Reposicionamento PCCTAE - Lei Nº 15.141/2025', denominacao_declaracao = 'Reposicionamento da Carreira conforme a Lei Nº 15.141/2025' WHERE id_tipo_progressao = 20;

-- Atualização da descrição dos reposicionamentos inseridos via script
UPDATE funcional.progressao SET descricao = replace(descricao, 'Medida Provisória Nº 1.286', 'Lei Nº 15.141/2025') WHERE descricao ILIKE 'Reposicionamento% - Medida Provisória Nº 1.286';