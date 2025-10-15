-- #337051 - Alterar tamanho de caracteres no campos de login

--------------------------------------------------------------
-- Script responsável por aumentar a quantidade de caracteres da coluna login
--------------------------------------------------------------

-- Remove as view para edição da coluna login.
DROP VIEW comum.view_redes_alunos_ldap;
DROP VIEW comum.view_redes_ldap;
DROP VIEW comum.view_redes_servidores_ldap;

-- Aumenta a quantidade de caracteres da coluna login.
ALTER TABLE comum.usuario ALTER COLUMN login TYPE character varying(100) COLLATE pg_catalog."default";
ALTER TABLE comum.auto_cadastro_discente ALTER COLUMN login TYPE character varying(100) COLLATE pg_catalog."default";

-- Recria as views removidas.
CREATE VIEW comum.view_redes_alunos_ldap
AS SELECT DISTINCT u.login,
    p.cpf_cnpj,
    p.passaporte,
    pais.nome AS pais_nome,
    p.celular AS telefone_celular,
    p.telefone AS telefone_fixo,
    p.email,
    p.nome AS pessoa_nome,
    p.data_nascimento,
    p.sexo,
    sd.descricao AS status_aluno,
    d.nivel,
    c.nome,
    (d.ano_ingresso || '.'::text) || d.periodo_ingresso AS data_ingresso
   FROM comum.usuario u
     JOIN comum.pessoa p USING (id_pessoa)
     JOIN comum.pais pais ON pais.id_pais = p.id_pais_nacionalidade
     JOIN discente d USING (id_pessoa)
     JOIN curso c USING (id_curso)
     JOIN status_discente sd ON sd.status = d.status
  WHERE (d.status = ANY (ARRAY[1, 8])) AND d.tipo = 1 AND d.id_curso = 92127264
  ORDER BY d.nivel;

CREATE VIEW comum.view_redes_ldap
AS SELECT u.login,
    p.cpf_cnpj,
    p.passaporte,
    pais.nome AS pais_nome,
    p.celular AS telefone_celular,
    p.telefone AS telefone_fixo,
    p.email,
    p.nome AS pessoa_nome,
    p.data_nascimento,
    p.sexo,
    s.id_servidor,
    sd.descricao AS status_aluno,
    (d.ano_ingresso || '.'::text) || d.periodo_ingresso AS data_ingresso,
        CASE
            WHEN s.id_categoria = 1 AND d.id_discente IS NOT NULL THEN '[Docente,Discente]'::text
            WHEN s.id_servidor IS NOT NULL AND d.id_discente IS NOT NULL THEN '[Servidor,Discente]'::text
            WHEN d.id_discente IS NOT NULL THEN '[Discente]'::text
            WHEN s.id_categoria IS NOT NULL THEN '[Docente]'::text
            WHEN s.id_servidor IS NOT NULL THEN '[Servidor]'::text
            ELSE '[Outros]'::text
        END AS vinculo
   FROM comum.usuario u
     JOIN comum.pessoa p USING (id_pessoa)
     JOIN comum.pais pais ON pais.id_pais = p.id_pais_nacionalidade
     LEFT JOIN rh.servidor s USING (id_pessoa)
     LEFT JOIN discente d USING (id_pessoa)
     LEFT JOIN status_discente sd ON sd.status = d.status
  ORDER BY u.login;

CREATE VIEW comum.view_redes_servidores_ldap
AS SELECT DISTINCT u.login,
    p.cpf_cnpj,
    p.passaporte,
    pais.nome AS pais_nome,
    p.celular AS telefone_celular,
    p.telefone AS telefone_fixo,
    p.email,
    p.nome AS pessoa_nome,
    p.data_nascimento,
    p.sexo,
    ss.descricao
   FROM comum.usuario u
     JOIN comum.pessoa p USING (id_pessoa)
     JOIN comum.pais pais ON pais.id_pais = p.id_pais_nacionalidade
     JOIN rh.servidor s USING (id_pessoa)
     JOIN rh.situacao_servidor ss USING (id_situacao)
  WHERE s.id_ativo = 1 AND u.inativo = false
  ORDER BY ss.descricao;