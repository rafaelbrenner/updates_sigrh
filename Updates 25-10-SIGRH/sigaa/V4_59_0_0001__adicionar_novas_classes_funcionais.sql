--#435027 - Adaptação Progressão Docente (Minuta sobre a Lei 11.091)

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


-- Adicionando os novos cargos - Banco SIGAA
INSERT INTO rh.cargo (id, denominacao, ano, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, id_tipo_categoria, inativo, sigla)
VALUES(647001, 'MةDICO - PCCTAE', 2025, 5, NULL, 2, 3, false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO rh.cargo (id, denominacao, ano, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, id_tipo_categoria, inativo, sigla)
VALUES(647002, 'MةDICO VETERINءRIO - PCCTAEO', 2025, 5, NULL, 2, 3, false, NULL) ON CONFLICT DO NOTHING;

UPDATE rh.cargo SET denominacao='MةDICO - PCCTAE', ano = 2025, id_tipo_nivel_funcional = 4, cbodesconhecido = NULL, id_tipo_origem = 2, id_tipo_categoria = 2, inativo = false, sigla = NULL WHERE id = 647001;
UPDATE rh.cargo SET denominacao='MةDICO VETERINءRIO - PCCTAE', ano = 2025, id_tipo_nivel_funcional = 4, cbodesconhecido = NULL, id_tipo_origem = 2, id_tipo_categoria = 2, inativo = false, sigla = NULL WHERE id = 647002;

-- Setando a classe E de técnico-administrativo para os servidores dos cargos de cَdigo 647001 e 647002. 
UPDATE rh.servidor SET id_classe_funcional = 12, ultima_atualizacao = now(), id_sistema_origem = 7 WHERE id_cargo IN (647001, 647002) AND id_classe_funcional = 104;
