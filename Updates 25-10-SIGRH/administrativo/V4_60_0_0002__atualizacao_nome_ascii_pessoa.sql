-- #454724 - Corre??o do nome_ascii no registro de Pessoas.

CREATE EXTENSION IF NOT EXISTS unaccent;
UPDATE comum.pessoa SET nome_ascii = unaccent(nome) WHERE nome IS NOT NULL AND nome_ascii <> unaccent(nome);
