-- ##435027 - Adaptação Progressão Docente (Minuta sobre a Lei 11.091)


---------------PROGRESSÃO DOCENTE-----------------------------------------

--Adicionando as novas classes do magistério superior
insert into rh.classe_funcional values (112, 'Classe A - Assistente', 1, 'A', 34);
insert into rh.classe_funcional values (113, 'Classe B - Adjunto', 1, 'B', 35);
insert into rh.classe_funcional values (114, 'Classe C - Associado', 1, 'C', 36);
insert into rh.classe_funcional values (115, 'Classe D - Titular', 1, 'D', 37);

--Adicionando as novas classes do EBTT
insert into rh.classe_funcional values (116, 'Classe A', 1, 'A', 38);
insert into rh.classe_funcional values (117, 'Classe B', 1, 'B', 39);
insert into rh.classe_funcional values (118, 'Classe C', 1, 'C', 40);
insert into rh.classe_funcional values (119, 'Titular', 1, 'T', 41);

--Inserindo o período de vigência na tabela de mapeamento de classe_funcional -> fita_espelho
alter table fita_espelho.classe_funcional_cargos add column inicio_vigencia date null;
comment on column fita_espelho.classe_funcional_cargos.inicio_vigencia is 'Indica a data de início de vigência da classe.';
alter table fita_espelho.classe_funcional_cargos add column termino_vigencia date null;
comment on column fita_espelho.classe_funcional_cargos.termino_vigencia is 'Indica a data de término de vigência da classe.';
update fita_espelho.classe_funcional_cargos set termino_vigencia = '2024-12-31' where termino_vigencia is null;

--Adicionando as novas classes do magistério superior na tabela de mapeamento
insert into fita_espelho.classe_funcional_cargos values (40, 1, 705001, 'A', 112, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (41, 1, 705001, 'B', 113, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (42, 1, 705001, 'C', 114, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (43, 1, 705001, 'D', 115, null, '2025-01-01', null);

--Adicionando as novas classes do EBTT na tabela de mapeamento
insert into fita_espelho.classe_funcional_cargos values (44, 1, 707001, 'A', 116, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (45, 1, 707001, 'B', 117, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (46, 1, 707001, 'C', 118, null, '2025-01-01', null);
insert into fita_espelho.classe_funcional_cargos values (47, 1, 707001, 'T', 119, null, '2025-01-01', null);

--Adicionando o reposicionamento como novo tipo de progressão
INSERT INTO rh_tipos.tipo_progressao VALUES (19, 'Reposicionamento na Carreira - Lei 11.091/2024', 1, false, 
'Enquadramento dos servidores docentes na nova estrutura de carreira do Magistério Superior e EBTT.', true, 'Reposicionamento da Carreira conforme a Lei 11.091/2024');

--Adicionando a nova regra de progressão de professor do magistério superior
INSERT INTO funcional.factory_regras_progressao (id_factory_regras_progressao,id_categoria, id_cargo, classe_concreta,ids_tipo_progressao,ids_classe_funcional,id_progressao_inicial,permite_selecao_manual,usar_nivel_vertical,validar,sugerir,id_perfil_carreira_progressao,inicio_vigencia,permite_varias_formacoes)
	VALUES (11,1,705001,'br.ufrn.sigrh.funcional.progressao.estrategias.docente.EstrategiaProgressaoMagisterioSuperior2024','.16.17.18.','.112.113.114.115','14',false,false,true,true,2,'2025-01-01',false);

--Adicionando a nova regra de progressão de professor do EBTT
INSERT INTO funcional.factory_regras_progressao (id_factory_regras_progressao,id_categoria, id_cargo, classe_concreta,ids_tipo_progressao,ids_classe_funcional,id_progressao_inicial,permite_selecao_manual,usar_nivel_vertical,validar,sugerir,id_perfil_carreira_progressao,inicio_vigencia,permite_varias_formacoes)
	VALUES (12,1,707001,'br.ufrn.sigrh.funcional.progressao.estrategias.docente.EstrategiaProgressaoMagisterioEnsinoBasicoLei2024','.16.17.18.','.116.117.118.119','14',false,false,true,true,3,'2025-01-01',false);

--Encerrando a vigência da regra antiga de progressão
update funcional.factory_regras_progressao set termino_vigencia = '2024-12-31' where id_factory_regras_progressao = 5; --magistério superior
update funcional.factory_regras_progressao set termino_vigencia = '2024-12-31' where id_factory_regras_progressao = 6; --EBTT



-- Adicionando os novos cargos - Banco Administrativo
INSERT INTO rh.cargo (id, denominacao, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, ano, id_tipo_categoria, inativo, id_agrupamento_funcional, sigla)
VALUES(647001, 'MEDICO - PCCTAE', 4, '0', 2, '2025', 2, false, NULL, '') ON CONFLICT DO NOTHING;

INSERT INTO rh.cargo (id, denominacao, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, ano, id_tipo_categoria, inativo, id_agrupamento_funcional, sigla)
VALUES(647002, 'MEDICO VETERINÁRIO - PCCTAE', 4, '0', 2, '2025', 2, false, NULL, '') ON CONFLICT DO NOTHING;

UPDATE rh.cargo SET denominacao = 'MÉDICO - PCCTAE', id_tipo_nivel_funcional = 4, cbodesconhecido = '0', id_tipo_origem = 2, ano = '2025', id_tipo_categoria = 2, inativo = false, id_agrupamento_funcional = NULL, sigla = '' WHERE id = 647001;
UPDATE rh.cargo SET denominacao = 'MÉDICO VETERINÁRIO - PCCTAE', id_tipo_nivel_funcional = 4, cbodesconhecido = '0', id_tipo_origem = 2, ano = '2025', id_tipo_categoria = 2, inativo = false, id_agrupamento_funcional = NULL, sigla = '' WHERE id = 647002;

-- Setando a classe E de técnico-administrativo para os servidores dos cargos de código 647001 e 647002. 
UPDATE rh.servidor SET id_classe_funcional = 12, ultima_atualizacao = now(), id_sistema_origem = 7 WHERE id_cargo IN (647001, 647002) AND id_classe_funcional = 104;

-- Setando a classe E de técnico-administrativo no histórico dos servidores dos cargos de código 647001 e 647002. 
UPDATE funcional.historico_servidor SET id_classe_funcional = 12 WHERE id_cargo IN (647001, 647002) AND id_classe_funcional = 104;