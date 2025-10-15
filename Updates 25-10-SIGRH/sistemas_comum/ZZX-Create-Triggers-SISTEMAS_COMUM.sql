--=============================================================================
-- BANCO COMUM
-- Criação das TRIGGERs para ser executado após SQLs de atualização da UFRN
--=============================================================================



CREATE TRIGGER tg_cadastroalteracaoemail_up
    AFTER UPDATE OF login, id_unidade, id_cargo, funcionario, email, inativo, id_setor, id_pessoa, tipo, id_aluno, id_servidor, autorizado, ramal, objetivo_cadastro, id_restaurante, usuario_protocolo, usuario_dmp, justificativa_negado, origem_cadastro, data_cadastro, id_foto, id_docente_externo, id_tutor, id_consultor, senha, id_consignataria, ultima_troca_senha, senha_mobile, hash_confirmacao_cadastro
    ON comum.usuario
    FOR EACH ROW
    EXECUTE PROCEDURE comum.usuario_updatealteracao();
	
	
	
CREATE TRIGGER tg_cadastroalteracaoemail_up
    AFTER UPDATE OF endereco, cep, uf, telefone, celular, fax, tipo, cpf_cnpj, complemento, nome_representante, nome, bairro, cidade, matricula, id_cargo, nome_fantasia, data_nascimento, sexo, email, funcionario, nitpis, emite_fatura, aliquota_imposto, internacional, passaporte, pais_origem, valido, origem, nome_mae, nome_oficial
    ON comum.pessoa
    FOR EACH ROW
    EXECUTE PROCEDURE comum.pessoa_updatealteracao();