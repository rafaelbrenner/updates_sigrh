-- #440606 - Alteração no Tipo de Incentivo à Qualificação

-- Criação das novas colunas na tabela formacao_escolar para armazenar as informações do tipo de incentivo de relação indireta.
alter table pessoal.formacao_escolar add column id_tipo_incentivo_historico integer;
comment on column pessoal.formacao_escolar.id_tipo_incentivo_historico is 'Identicador do tipo de incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column inicio_incentivo_historico timestamp;
comment on column pessoal.formacao_escolar.inicio_incentivo_historico is 'Data de início do incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column processo_de_concessao_historico character varying(30);
comment on column pessoal.formacao_escolar.processo_de_concessao_historico is 'Processo de concessão do incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column certificado_pendente_historico boolean;
comment on column pessoal.formacao_escolar.certificado_pendente_historico is 'Indica se há certificado pendente no incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column percentual_historico float;
comment on column pessoal.formacao_escolar.percentual_historico is 'Percentual do incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column termino_incentivo_historico timestamp;
comment on column pessoal.formacao_escolar.termino_incentivo_historico is 'Data de término do incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column id_status_incentivo_historico integer;
comment on column pessoal.formacao_escolar.id_status_incentivo_historico is 'Identicador do status do incentivo cadastrado na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

alter table pessoal.formacao_escolar add column observacao_historico text;
comment on column pessoal.formacao_escolar.observacao_historico is 'Observação cadastrada na formação antes da alteração relacionada à Medida Provisória 1286/2024.';

--Atualização das novas colunas na tabela formacao_escolar para armazenar as informações do incentivo de relação indireta nos casos em que o incentivo ainda não foi encerrado.
update 
	pessoal.formacao_escolar 
set 
	id_tipo_incentivo_historico = id_tipo_incentivo_qualificacao,
	inicio_incentivo_historico = inicio_incentivo,
	processo_de_concessao_historico = processo_de_concessao,
	certificado_pendente_historico = certificado_pendente,
	percentual_historico = percentual,
	termino_incentivo_historico = termino_incentivo,
	id_status_incentivo_historico = id_status_incentivo_capacitacao,
	observacao_historico = observacao
where id_tipo_incentivo_qualificacao = 2 and termino_incentivo is null;

--Atualização das informações do novo incentivo de relação direta, nos registros de formação escolar que possuem incentivo de realação indireta sem datá de término cadastrada. 
update 
	pessoal.formacao_escolar fe
set 
	id_tipo_incentivo_qualificacao = 1,
	observacao = 'Alteração realizada automaticamente via sistema, relacionada à Medida Provisória 1286/2024.',
	termino_incentivo_historico = '2024-12-31',
	inicio_incentivo = '2025-01-01',
	percentual = (case 
		when id_tipo_formacao = 11 then 10
		when id_tipo_formacao = 13 then 15
		when id_tipo_formacao = 1 then 20
		when id_tipo_formacao = 4 then 25
		when id_tipo_formacao = 25 then 30
		when id_tipo_formacao = 26 then 52
		when id_tipo_formacao = 27 then 75
	end) 
where id_tipo_incentivo_qualificacao = 2 and termino_incentivo is null;




