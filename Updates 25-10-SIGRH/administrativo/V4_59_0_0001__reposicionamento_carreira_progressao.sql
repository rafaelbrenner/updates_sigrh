-- #433719 - Adaptação Progressão por Mérito (Minuta sobre a Lei 11.091)
-- #435027 - Adaptação Progressão Docente (Minuta sobre a Lei 11.091)

/* URGENTE, VERIFICAR COM EQUIPE DE NEGÓCIO ESSE SCRITP - NÃO RODOU 


---------------------------------------Inserts-----------------------------------------------------

--insert do INICIO DE CARREIRA
insert into funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, nivel_horizontal, nivel_vertical, 
data_de_vigencia, id_classe_funcional, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh)
SELECT nextval('funcional.progressao_seq'), s.id_servidor, 14, now(), null, 1, 
	case when s.admissao < '2025-01-01' and s.id_categoria = 2
	then 1
	else -9999 end as nivel_vertical, 
s.admissao , s.id_classe_funcional, now(), 3, null, null, false, false
FROM rh.servidor s
join comum.pessoa pessoa on pessoa.id_pessoa = s.id_pessoa
join rh.cargo c on s.id_cargo = c.id
join rh.categoria categoria on categoria.id_categoria = s.id_categoria
where s.id_servidor not in (select distinct prog.id_servidor
							from funcional.progressao prog
							join rh.servidor serv on serv.id_servidor = prog.id_servidor) 
	and s.id_ativo = 1 
	and s.data_desligamento is null
	and s.id_situacao in (1, 8, 11)
	and s.redistribuido = false
	and ((s.id_cargo in (705001, 707001) and s.id_categoria = 1) or s.id_categoria = 2);


--insert do reposicionamento dos servidores Técnicos Administrativos 
--para executar ANTES do processamento da fita-espelho de abril/2025
--nesse script, o reposicionamento é realizado a partir das informações da coluna Referência/Nível/Padrão/ da tabela do servidor.
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, 
nivel_horizontal, 
nivel_vertical, data_de_vigencia, id_classe_funcional, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh)
SELECT nextval('funcional.progressao_seq'), s.id_servidor, 20, now(), 'Reposicionamento PCCTAE - Medida Provisória Nº 1.286', 
substring(s.referencia_nivel_padrao, 2, 2)::integer + substring(s.referencia_nivel_padrao, 1, 1)::integer - 1, 
-9999, '2025-01-01', s.id_classe_funcional, now(), 3, null, null, false, false
from rh.servidor s 
where s.redistribuido = false and s.id_categoria = 2 and s.data_desligamento is null and s.admissao < '2025-01-01' and s.id_situacao in (1,8,11);

--insert do reposicionamento dos servidores DOCENTES (considerando as progressões realizadas no ano de 2025)
--para executar ANTES do processamento da fita-espelho de abril/2025
--nesse script, o reposicionamento é realizado a partir das informações da coluna Referência/Nível/Padrão/ da tabela do servidor.
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, nivel_vertical, 
data_de_vigencia, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh, 
id_classe_funcional, nivel_horizontal)
SELECT nextval('funcional.progressao_seq'), s.id_servidor, 19, now(), 'Reposicionamento na Carreira - Medida Provisória Nº 1.286', 
-9999, '2025-01-01', now(), 3, null, null, false, false, 
case when s.id_classe_funcional in (105,106,107,108) --Antigas classes A e B
		then  112 --nova classe A - Assistente
	 when s.id_classe_funcional = 109 --Antiga classe C
	 	then 113 --nova classe B - Adjunto
	 when s.id_classe_funcional = 110 --Antiga classe D
	 	then 114 --nova classe C - Associado
	 when s.id_classe_funcional = 111 --Antiga classe E
	 	then 115 --nova classe D - Titular
	 when s.id_classe_funcional in (99,100) --Antigas classes DI e DII (EBTT)
	 	then 116 --nova classe A
	 when s.id_classe_funcional = 101 --Antiga classe DIII (EBTT)
	 	then 117 --nova classe B
	 when s.id_classe_funcional = 102 --Antiga classe DIV (EBTT)
	 	then 118 --nova classe C
	 when s.id_classe_funcional = 103 --Antiga classe DV Titular (EBTT)
	 	then 119 --nova classe Titular
end as classe_funcional,
case when s.id_classe_funcional in (105,106,107,108) 
		then  1
	 when s.id_classe_funcional = 109
	 	then substring(s.referencia_nivel_padrao, 2, 2)::integer
	 when s.id_classe_funcional = 110
	 	then substring(s.referencia_nivel_padrao, 2, 2)::integer
	 when s.id_classe_funcional = 111
	 	then 1
	 when s.id_classe_funcional in (99,100)
	 	then 1
	 when s.id_classe_funcional = 101
	 	then substring(s.referencia_nivel_padrao, 2, 2)::integer
	 when s.id_classe_funcional = 102
	 	then substring(s.referencia_nivel_padrao, 2, 2)::integer
	 when s.id_classe_funcional = 103
	 	then 1
end as nivel_horizontal 
from rh.servidor s 
where s.redistribuido = false and s.id_categoria = 1 and s.data_desligamento is null and s.admissao < '2025-01-01' 
		and s.id_cargo in (705001, 707001) and s.id_situacao in (1,8,11);

--insert do reposicionamento dos servidores Técnicos Administrativos 
--para executar APÓS processamento de uma fita-espelho a partir de abril/2025
--executado na UFRN
--utiliza as informações da progressão mais recente cadastrada para o servidor
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, 
nivel_horizontal, nivel_vertical, data_de_vigencia, id_classe_funcional, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh) 
SELECT nextval('funcional.progressao_seq'), s.id_servidor, 20, now(), 'Reposicionamento PCCTAE - Medida Provisória Nº 1.286', 
        (p.nivel_horizontal + p.nivel_vertical - 1), 
        -9999, '2025-01-01', p.id_classe_funcional, now(), 3, null, null, false, false  
FROM funcional.progressao p 
JOIN rh.servidor s ON s.id_servidor = p.id_servidor
INNER JOIN (
    SELECT p1.id_servidor, p1.id_progressao
    FROM funcional.progressao p1
    LEFT JOIN funcional.progressao p2 ON (
        p1.id_servidor = p2.id_servidor AND 
        p1.id_progressao <> p2.id_progressao
        AND (p1.data_de_vigencia < p2.data_de_vigencia OR (p1.data_de_vigencia = p2.data_de_vigencia AND p1.data < p2.data))
    )
    WHERE p2.id_progressao IS NULL AND p1.id_tipo_progressao NOT IN (20)
) p2 ON p.id_servidor = p2.id_servidor AND p.id_progressao = p2.id_progressao
WHERE s.redistribuido = FALSE AND s.id_categoria = 2 AND s.data_desligamento IS NULL AND s.admissao < '2025-01-01' 
AND s.id_situacao in (1,8,11);


--insert do reposicionamento dos servidores DOCENTES (Magistério Superior e EBTT)
--para executar APÓS processamento de uma fita-espelho a partir de abril/2025
--executado na UFRN
--utiliza as informações da progressão mais recente cadastrada para o servidor
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, nivel_vertical, 
data_de_vigencia, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh, 
id_classe_funcional, nivel_horizontal)
	SELECT nextval('funcional.progressao_seq'), s.id_servidor, 19, now(), 'Reposicionamento na Carreira - Medida Provisória Nº 1.286', 
	-9999, '2025-01-01', now(), 3, null, null, false, false, 
	case when p.id_classe_funcional in (105,106,107,108) --Antigas classes A e B
			then  112 --nova classe A - Assistente
		 when p.id_classe_funcional = 109 --Antiga classe C
		 	then 113 --nova classe B - Adjunto
		 when p.id_classe_funcional = 110 --Antiga classe D
		 	then 114 --nova classe C - Associado
		 when p.id_classe_funcional = 111 --Antiga classe E
		 	then 115 --nova classe D - Titular
		 when p.id_classe_funcional in (99,100) --Antigas classes DI e DII (EBTT)
		 	then 116 --nova classe A
		 when p.id_classe_funcional = 101 --Antiga classe DIII (EBTT)
		 	then 117 --nova classe B
		 when p.id_classe_funcional = 102 --Antiga classe DIV (EBTT)
		 	then 118 --nova classe C
		 when p.id_classe_funcional in (103,7) --Antiga classe DV Titular (EBTT)
		 	then 119 --nova classe Titular
		 else 
		 	p.id_classe_funcional
	end as classe_funcional,
	case when p.id_classe_funcional in (105,106,107,108) 
			then  1
		 when p.id_classe_funcional = 109
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 110
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 111
		 	then 1
		 when p.id_classe_funcional in (99,100)
		 	then 1
		 when p.id_classe_funcional = 101
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 102
		 	then p.nivel_horizontal
		 when p.id_classe_funcional in (103,7)
		 	then 1
		 else 
		 	p.nivel_horizontal
	end as nivel_horizontal 
	from funcional.progressao p 
	join rh.servidor s on s.id_servidor = p.id_servidor
	INNER JOIN (
	    SELECT p1.id_servidor, p1.id_progressao
	    FROM funcional.progressao p1
	    LEFT JOIN funcional.progressao p2 ON (
	        p1.id_servidor = p2.id_servidor AND 
	        p1.id_progressao <> p2.id_progressao
	        AND (p1.data_de_vigencia < p2.data_de_vigencia OR (p1.data_de_vigencia = p2.data_de_vigencia AND p1.data < p2.data))
	    )
	    WHERE p2.id_progressao IS NULL AND p1.id_tipo_progressao NOT IN (19)
	) p2 ON p.id_servidor = p2.id_servidor AND p.id_progressao = p2.id_progressao
	where s.redistribuido = false and s.id_categoria = 1 and s.data_desligamento is null and s.admissao < '2025-01-01' 
			and s.id_cargo in (705001, 707001) and s.id_situacao in (1,8,11);
			

--insert do reposicionamento dos servidores Técnicos Administrativos Redistribuidos
--para executar APÓS processamento de uma fita-espelho a partir de abril/2025
--executado na UFRN
--utiliza as informações da progressão mais recente cadastrada para o servidor
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, 
nivel_horizontal, nivel_vertical, data_de_vigencia, id_classe_funcional, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh) 
SELECT nextval('funcional.progressao_seq'), s.id_servidor, 20, now(), 'Reposicionamento PCCTAE - Medida Provisória Nº 1.286', 
        (p.nivel_horizontal + p.nivel_vertical - 1), 
        -9999, '2025-01-01', p.id_classe_funcional, now(), 3, null, null, false, false  
FROM funcional.progressao p 
JOIN rh.servidor s ON s.id_servidor = p.id_servidor
INNER JOIN (
    SELECT p1.id_servidor, p1.id_progressao
    FROM funcional.progressao p1
    LEFT JOIN funcional.progressao p2 ON (
        p1.id_servidor = p2.id_servidor AND 
        p1.id_progressao <> p2.id_progressao
        AND (p1.data_de_vigencia < p2.data_de_vigencia OR (p1.data_de_vigencia = p2.data_de_vigencia AND p1.data < p2.data))
        AND p1.ativo = true AND p2.ativo = true
    )
    WHERE p2.id_progressao IS NULL AND p1.id_tipo_progressao NOT IN (20) AND p1.ativo = true 
) p2 ON p.id_servidor = p2.id_servidor AND p.id_progressao = p2.id_progressao
WHERE s.redistribuido = true AND s.id_categoria = 2 AND s.data_desligamento IS NULL AND s.admissao < '2025-01-01' 
AND s.id_situacao IN (1,8,11);


--insert do reposicionamento dos servidores DOCENTES (Magistério Superior e EBTT) redistribuidos
--para executar APÓS processamento de uma fita-espelho a partir de abril/2025
--executado na UFRN
--utiliza as informações da progressão mais recente cadastrada para o servidor
INSERT INTO funcional.progressao(id_progressao, id_servidor, id_tipo_progressao, data, descricao, nivel_vertical, 
data_de_vigencia, data_publicacao, id_tipo_publicacao, id_formacao_escolar, numero_portaria, dap, sigrh, 
id_classe_funcional, nivel_horizontal)
	SELECT nextval('funcional.progressao_seq'), s.id_servidor, 19, now(), 'Reposicionamento na Carreira - Medida Provisória Nº 1.286', 
	-9999, '2025-01-01', now(), 3, null, null, false, false, 
	case when p.id_classe_funcional in (105,106,107,108) --Antigas classes A e B
			then  112 --nova classe A - Assistente
		 when p.id_classe_funcional = 109 --Antiga classe C
		 	then 113 --nova classe B - Adjunto
		 when p.id_classe_funcional = 110 --Antiga classe D
		 	then 114 --nova classe C - Associado
		 when p.id_classe_funcional = 111 --Antiga classe E
		 	then 115 --nova classe D - Titular
		 when p.id_classe_funcional in (99,100) --Antigas classes DI e DII (EBTT)
		 	then 116 --nova classe A
		 when p.id_classe_funcional = 101 --Antiga classe DIII (EBTT)
		 	then 117 --nova classe B
		 when p.id_classe_funcional = 102 --Antiga classe DIV (EBTT)
		 	then 118 --nova classe C
		 when p.id_classe_funcional in (103,7) --Antiga classe DV Titular (EBTT)
		 	then 119 --nova classe Titular
		 else 
		 	p.id_classe_funcional
	end as classe_funcional,
	case when p.id_classe_funcional in (105,106,107,108) 
			then  1
		 when p.id_classe_funcional = 109
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 110
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 111
		 	then 1
		 when p.id_classe_funcional in (99,100)
		 	then 1
		 when p.id_classe_funcional = 101
		 	then p.nivel_horizontal
		 when p.id_classe_funcional = 102
		 	then p.nivel_horizontal
		 when p.id_classe_funcional in (103,7)
		 	then 1
		 else 
		 	p.nivel_horizontal
	end as nivel_horizontal 
	from funcional.progressao p 
	join rh.servidor s on s.id_servidor = p.id_servidor
	INNER JOIN (
	    SELECT p1.id_servidor, p1.id_progressao
	    FROM funcional.progressao p1
	    LEFT JOIN funcional.progressao p2 ON (
	        p1.id_servidor = p2.id_servidor AND 
	        p1.id_progressao <> p2.id_progressao
	        AND (p1.data_de_vigencia < p2.data_de_vigencia OR (p1.data_de_vigencia = p2.data_de_vigencia AND p1.data < p2.data))
	        AND p1.ativo = true AND p2.ativo = true
	    )
	    WHERE p2.id_progressao IS NULL AND p1.id_tipo_progressao NOT IN (19) AND p1.ativo = true 
	) p2 ON p.id_servidor = p2.id_servidor AND p.id_progressao = p2.id_progressao
	WHERE s.redistribuido = true AND s.id_categoria = 1 AND s.data_desligamento IS null AND s.admissao < '2025-01-01' 
			AND s.id_cargo IN (705001, 707001) AND s.id_situacao IN (1,8,11);




------------------------------------------updates------------------------------------------------------

--update das classes do servidor para correções APÓS processamento de uma fita-espelho a partir de abril/2025
UPDATE rh.servidor serv SET id_classe_funcional = x.id_classe_nova, 
id_sistema_origem = 7, ultima_atualizacao = now(), pendente_sincronizacao = true 
FROM (
    SELECT s.siape, cf.id_classe_funcional AS id_classe_old, cf_n.id_classe_funcional AS id_classe_nova, id_cargo 
    FROM rh.servidor s
    INNER JOIN rh.classe_funcional cf ON (cf.id_classe_funcional = s.id_classe_funcional)
    LEFT JOIN fita_espelho.classe_funcional_cargos cfc ON (
        cfc.sigla_classe_funcional = cf.sigla AND cfc.id_categoria = s.id_categoria 
        AND (cfc.id_cargo_restricao = s.id_cargo OR cfc.id_cargo_restricao IS NULL)
        AND (cfc.id_formacao_restricao = s.id_formacao OR id_formacao_restricao IS NULL)
        AND cfc.inicio_vigencia >= make_date(2025, 1, 1) 
    )
    LEFT JOIN rh.classe_funcional cf_n ON (cf_n.id_classe_funcional = cfc.id_classe_funcional)
    WHERE s.id_categoria = 1 AND s.id_tipo_regime_juridico IN (1, 2)
    AND s.id_classe_funcional <> cf_n.id_classe_funcional AND s.id_categoria = 1 AND s.id_tipo_regime_juridico IN (1, 2)
) AS x WHERE serv.siape = x.siape  AND x.id_classe_nova IS NOT NULL;

-- Setando a classe Titular de docentes do EBTT para os servidores da antiga classe DV
UPDATE rh.servidor s SET id_classe_funcional = 119, ultima_atualizacao = now(), id_sistema_origem = 7 
	WHERE id_cargo = 707001 AND id_classe_funcional = 107 and data_desligamento is null;

--update do historico do servidor para correções após processamento de uma fita-espelho a partir de abril/2025
update funcional.historico_servidor hs set id_classe_funcional = classe.classe_funcional
FROM (
    select s.id_servidor as id_servidor, s.id_classe_funcional as classe_funcional
    from rh.servidor s  
    WHERE s.id_categoria = 1 AND s.id_tipo_regime_juridico IN (1, 2) and s.id_cargo in (705001, 707001) and s.data_desligamento is null
) as classe where hs.mes >= 4 and hs.ano >= 2025 and classe.id_servidor = hs.id_servidor;

-- Setando a classe Titular de docentes do EBT  no histórico para os servidores da antiga classe DV
UPDATE funcional.historico_servidor SET id_classe_funcional = 119 
	WHERE mes = 4 and ano = 2025 AND id_cargo = 707001 AND id_classe_funcional = 107;


*/ 


