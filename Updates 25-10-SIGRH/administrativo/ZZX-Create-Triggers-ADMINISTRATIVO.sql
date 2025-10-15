--=============================================================================
-- BANCO ADMINISTRATIVO
-- Criação das TRIGGERs para ser executado após SQLs de atualização da UFRN
--=============================================================================



CREATE TRIGGER tg_cadastroalteracaoemail_up
AFTER UPDATE OF expira_senha, login, id_unidade, funcionario, ultimo_acesso, email, inativo, id_setor, id_pessoa, ano_orcamentario, tipo, id_aluno, id_servidor, autorizado, ramal, objetivo_cadastro, id_restaurante, usuario_protocolo, usuario_dmp, justificativa_negado, data_cadastro, origem_cadastro, id_foto, senha, id_consignataria, id_plano_saude
ON comum.usuario
FOR EACH ROW
EXECUTE PROCEDURE comum.usuario_updatealteracao();

CREATE TRIGGER tg_cadastroalteracaoemail_up
AFTER UPDATE OF endereco, cep, uf, telefone, celular, fax, tipo, cpf_cnpj, complemento, nome_representante, nome, bairro, cidade, nome_fantasia, data_nascimento, sexo, email, funcionario, nitpis, emite_fatura, aliquota_imposto, internacional, passaporte, pais_origem, valido, nome_mae, nome_pai, uf_nascimento, id_tipo_estado_civil, id_tipo_escolaridade, id_tipo_formacao, id_tipo_nacionalidade, id_pais, ano_chegada, endereco_logradouro, endereco_numero, endereco_complemento, registro_geral, rg_orgao_expedidor, rg_data_expedicao, rg_uf, eleitor, zona_eleitoral, secao_eleitoral, eleitor_uf, reservista, categoria_reservista, regiao_militar, cor_raca, id_banco, agencia_banco, conta_corrente, id_estado, telefone_comercial, pessoa_atualizada, id_perfil, cpf_cnpj_antigo, tipo_conta_corrente, nome_ascii, id_tipo_necessidade_especial, id_municipio_naturalidade, data_titulo_eleitoral, cnh_numero, cnh_registro, cnh_uf, cnh_data_primeira_habilitacao, cnh_data_expedicao, cnh_data_validade, serie_reservista, orgao_reservista, data_reservista, nome_conjuge, ctps_serie, ctps_orgao_expeditor, ctps_uf, ctps_data_expedicao, ctps_numero, id_categoria_carteira_habilitacao, id_grupo_sanguineo, nome_social, autoriza_dirpf, id_entrada_autorizacao_dirpf, codigo_area_telefone, codigo_area_celular, inscricao_estadual, site, observacoes, id_tipo_raca, nome_oficial, cidade_origem, uasg
ON comum.pessoa
FOR EACH ROW
EXECUTE PROCEDURE comum.pessoa_updatealteracao();