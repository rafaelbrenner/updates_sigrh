-- Script não rodou, verificar com a UFRN
-- #450594 - Adição de link Solicitação Eletrônica e Agendar Eventos
-- #452283 - Criação de links para funcionalidades da aba de recadastramentos

-- script necessário apenas no caso de estar sendo usado o novo portal público do sigrh, utilizado para preencher informações de caso de uso utilizado na busca geral do sistema.
-- OBSERVAÇÃO: Adiciona as URLs na tabela "comum.caso_uso_publico" apenas se elas não existirem.
/*
CREATE FUNCTION adicionaCasosDeUsoSigrhPublicoLink()
RETURNS varchar AS $$
DECLARE linkSigrh varchar;
DECLARE linkSigrhPublico varchar;
DECLARE siglaInstituicao varchar;
        begin
        	SELECT (valor || '/') INTO siglaInstituicao  from comum.dados_institucionais WHERE nome = 'siglaInstituicao';
	        SELECT (valor || '/sigrh/') INTO linkSigrh  from comum.dados_institucionais WHERE   nome = 'linkSigrh';
			SELECT (url || '/') INTO linkSigrhPublico  from comum.sistema s  WHERE descricao = 'SIGRH PUBLICO';
	   
			INSERT INTO comum.caso_uso_publico (id_caso_uso_publico, codigo, nome, descricao, link, id_sistema, id_sub_sistema) 
	       	SELECT 
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Acompanhar/Solicitar',
				'Faça uma solicitação eletrônica para a Administração de Pessoal. Seja atendido com rapidez e comodidade.',
				linkSigrh || 'public/consultarServicoPublico/solicitacao-eletronica',
				7,
				101700 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Acompanhar/Solicitar'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Agendar evento',
				'Agende um encontro com um dos nossos pró-reitores. Seja atendido com rapidez e comodidade.',
				linkSigrhPublico || 'servicos/buscar-evento',
				7,
				102500 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Agendar evento'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Requerimentos',
				'Visualize vários formulários de requerimentos.',
				linkSigrh || 'public/consultarServicoPublico/formularios-requerimentos',
				7,
				102000 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Requerimentos'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Abono',
				'Imprima o formulário de abono de permanência.',
				linkSigrh || 'public/consultarServicoPublico/formularios-abono',
				7,
				102000 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Abono'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Aposentadoria',
				'Imprima o formulário de solicitação de aposentadoria.',
				linkSigrh || 'public/consultarServicoPublico/formularios-aposentadoria',
				7,
				102000 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Aposentadoria'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Termo de Afastamento',
				'Imprima o termo de afastamento.',
				linkSigrh || 'public/consultarServicoPublico/formularios-afastamento',
				7,
				102000 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Termo de Afastamento'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Auxílio Transporte',
				'Faça o recadastramento das linhas de transportes utilizadas em seu deslocamento até a '||siglaInstituicao||'.',
				linkSigrh || 'public/consultarServicoPublico/recadastramentos-auxilio-transporte',
				7,
				100100 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Auxílio Transporte'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				)
			UNION SELECT
				nextval('comum.caso_uso_publico_seq'),
				NULL,
				'Cadastro de Dependentes',
				'Realize o cadastro eletrônico de seus dependentes.',
				linkSigrh || 'public/consultarServicoPublico/recadastramentos-dependentes',
				7,
				100100 
				WHERE NOT EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup WHERE nome = 'Cadastro de Dependentes'
				) AND 
				EXISTS (
					SELECT nome FROM comum.caso_uso_publico cup LIMIT 1
				);
					       	
	       return linkSigrh;
        END;
$$ LANGUAGE plpgsql;
select adicionaCasosDeUsoSigrhPublicoLink();
DROP FUNCTION if exists adicionaCasosDeUsoSigrhPublicoLink();
*/
 