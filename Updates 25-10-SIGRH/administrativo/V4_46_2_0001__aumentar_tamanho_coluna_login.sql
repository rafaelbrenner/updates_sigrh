--#337051 - Alterar tamanho de caracteres no campos de login

--------------------------------------------------------------
-- Script responsável por aumentar a quantidade de caracteres da coluna login
--------------------------------------------------------------

-- Aumenta a quantidade de caracteres da coluna login.
ALTER TABLE comum.usuario ALTER COLUMN login TYPE character varying(100) COLLATE pg_catalog."default";