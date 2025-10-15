-- #433719 - Adaptação Progressão por Mérito (Minuta sobre a Lei 11.091)

INSERT INTO rh_tipos.tipo_progressao (id_tipo_progressao, denominacao,id_tipo_categoria,exige_formacao_capacitacao,descricao,enquadramento_carreira,denominacao_declaracao) VALUES
	(20, 'Reposicionamento PCCTAE - Lei 11.091/2024',2,false,NULL,true,'Reposicionamento da Carreira conforme Lei 11.091/2024');

INSERT INTO rh_tipos.tipo_progressao (id_tipo_progressao, denominacao,id_tipo_categoria,exige_formacao_capacitacao,descricao,enquadramento_carreira,denominacao_declaracao) VALUES
	(21, 'ACELERAÇÃO DA PROGRESSÃO',2,false,'Aceleração de progressão por capacitação.',false,NULL);
	
INSERT INTO funcional.factory_regras_progressao (id_factory_regras_progressao,id_categoria,classe_concreta,ids_tipo_progressao,ids_classe_funcional,id_progressao_inicial,permite_selecao_manual,usar_nivel_vertical,validar,sugerir,id_perfil_carreira_progressao,inicio_vigencia,permite_varias_formacoes)
	VALUES (10,2,'br.ufrn.sigrh.funcional.progressao.estrategias.tecnicoadministrativo.EstrategiaProgressaoTecnicoAdministrativo2024','.6.21.','.8.9.10.11.12.','14',false,false,true,true,1,'2025-01-01',true);

update funcional.factory_regras_progressao set termino_vigencia = '2024-12-31' where id_factory_regras_progressao = 9;

alter table funcional.progressao add column saldo integer;
comment on column funcional.progressao.saldo is ' Valor (em meses) acumulado por servidores com mais de 12 meses da última progressão por mérito.';