--#433719 - Adaptação Progressão por mérito (Minuta sobre a Lei 11.091)

INSERT INTO comum.parametro (nome, descricao, valor, id_subsistema, id_sistema, codigo)
VALUES		('PADRAO_VENCIMENTO_MAXIMO_TECNICO',
			'Ní­vel máximo que um servidor técnico-administrativo pode obter através de progressões por mérito (MP 1286/2024).',
			'19',100100,7,'7_100100_349'), 
			('MESES_PROGRESSAO_TEC_ADMINISTRATIVO',
			'Tempo, em meses, de trabalho para obtenção de progressões por mérito (MP 1286/2024).',
			'12',100100,7,'7_100100_350'),
			('DATA_ENQUADRAMENTO_TECNICO_2025',
			'Data em que houve o enquadramento dos servidores técnicos-administrativos (MP 1286/2024).',
			'01-01-2025',100100,7,'7_100100_351'),
			('TIPO_PROGRESSAO_REPOSICIONAMENTO_2025',
			'Parametro que representa o id de tipo de progressÃ£o do reposicionamento para técnicos-administrativos (MP 1286/2024).',
			'20',100100,7,'7_100100_283');
			

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


-- Adicionando os novos cargos - Banco Comum
INSERT INTO rh.cargo (id, denominacao, ano, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, id_tipo_categoria, inativo, sigla)
VALUES(647001, 'MÉDICO - PCCTAE', 2025, 5, NULL, 2, 3, false, NULL) ON CONFLICT DO NOTHING;

INSERT INTO rh.cargo (id, denominacao, ano, id_tipo_nivel_funcional, cbodesconhecido, id_tipo_origem, id_tipo_categoria, inativo, sigla) 
VALUES(647002, 'MÉDICO VETERINÐ‘RIO - PCCTAE', 2025, 5, NULL, 2, 3, false, NULL) ON CONFLICT DO NOTHING;

UPDATE rh.cargo SET denominacao='MÉDICO - PCCTAE', ano = 2025, id_tipo_nivel_funcional = 4, cbodesconhecido = NULL, id_tipo_origem = 2, id_tipo_categoria = 2, inativo = false, sigla = NULL WHERE id = 647001;
UPDATE rh.cargo SET denominacao='MÉDICO VETERINÁRIO - PCCTAE', ano = 2025, id_tipo_nivel_funcional = 4, cbodesconhecido = NULL, id_tipo_origem = 2, id_tipo_categoria = 2, inativo = false, sigla = NULL WHERE id = 647002;

-- Setando a classe E de tecnico-administrativo para os servidores dos cargos de código 647001 e 647002. 
UPDATE rh.servidor SET id_classe_funcional = 12, ultima_atualizacao = now(), id_sistema_origem = 7 WHERE id_cargo IN (647001, 647002) AND id_classe_funcional = 104;

--Atualizando o texto do boletim de publicação de progressões efetivadas 
update comum.template_documento td set texto = '<p><strong>Portaria nÑ” ##NUMERO_PORTARIA##/##ANO_PORTARIA##-##SIGLA_UNIDADE##, de ##DATA_SOLICITACAO_BOLETIM##.</strong><br>O(A) ##DESIGNACAO_CHEFIA## de Gestão de Pessoas DO(A) ##NOME_INSTITUICAO##, no uso da competência que lhe foi delegada pelo Magní­fico Reitor através da Portaria n 1.270-R, de 23/10/1995, CONSIDERANDO o art. 10-B e os § 1°” e § 2°”, da Lei 11.091,<br> <br> R E S O L V E<br> Conceder a Progressão por Mérito Profissional aos servidores a seguir relacionados, de acordo com a vigência e o respectivo padrão de vencimento:<br> <br> ##TABELA_PROGRESSOES##<br> <br> (a) ##NOME_CHEFE## - ##DESIGNACAO_CHEFIA##</p>'
where codigo = '7_100500_7'

