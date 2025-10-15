-- #456557 - Uso do saldo de progress?o por m?rito

-- Atualiza??o para servidores com apenas in?cio de carreira e reposicionamento
UPDATE funcional.progressao p SET saldo = x.saldo_em_dias FROM (
	SELECT DISTINCT p.id_progressao, EXTRACT(DAY FROM p.data_de_vigencia - INTERVAL '12 month' - p_ult.data_de_vigencia) AS saldo_em_dias
	FROM funcional.progressao p 
	INNER JOIN (
	   	SELECT DISTINCT ON (atual.id_progressao) atual.id_progressao AS id_progressao_atual, 
	   	ult.id_progressao, ult.DATA, ult.data_de_vigencia, ult.id_tipo_progressao, ult.nivel_vertical, ult.nivel_horizontal, ult.saldo
		FROM funcional.progressao atual
		INNER JOIN funcional.progressao ult ON (
			ult.id_servidor = atual.id_servidor AND 
	        ult.id_progressao <> atual.id_progressao AND
	        ult.id_tipo_progressao IN (atual.id_tipo_progressao, 14)
	        AND (ult.data_de_vigencia < atual.data_de_vigencia OR (ult.data_de_vigencia = atual.data_de_vigencia AND ult.data < atual.data))
	        AND ult.ativo = true
		)
		WHERE atual.ativo = TRUE AND atual.saldo > 0 AND atual.id_tipo_progressao IN (6) AND ult.ativo = TRUE
		ORDER BY atual.id_progressao, ult.data_de_vigencia DESC, ult.DATA DESC
	) AS p_ult ON (p.id_progressao = p_ult.id_progressao_atual)
	WHERE p.ativo = TRUE
) AS x WHERE x.id_progressao = p.id_progressao AND p.saldo > 0 AND p.saldo < 10;