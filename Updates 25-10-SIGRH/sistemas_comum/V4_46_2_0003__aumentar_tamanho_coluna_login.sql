--#337051 - Alterar tamanho de caracteres no campos de login

--------------------------------------------------------------
-- Script responsável por aumentar a quantidade de caracteres da coluna login
--------------------------------------------------------------

-- Remove view do iproject para edição da coluna login.
DROP VIEW iproject.usuarios;

-- Aumenta a quantidade de caracteres da coluna.
ALTER TABLE comum.usuario ALTER COLUMN login TYPE character varying(100) COLLATE pg_catalog."default";

-- Recria a view do Iproject.
CREATE VIEW iproject.usuarios
AS SELECT u.login,
    i.id_permissao,
    i.id_usuario,
    i.testador,
    i.desenvolvedor,
    i.requisitos,
    i.suporte,
    i.gerente,
    u.inativo
   FROM iproject.permissao_iproject i,
    comum.usuario u
  WHERE i.id_usuario = u.id_usuario
  ORDER BY u.login;