-- #442499 - erro na ficha de inscrição item "Quitação Militar" para mulheres

ALTER TABLE concurso.tipo_documento_concurso ADD id_genero int4 NULL;
COMMENT ON COLUMN concurso.tipo_documento_concurso.id_genero IS 'Identificador do gênero para qual o tipo de documentação é exigido.';
ALTER TABLE concurso.tipo_documento_concurso ADD CONSTRAINT tipo_documento_concurso_genero_fk FOREIGN KEY (id_genero) REFERENCES comum.genero(id_genero);

UPDATE concurso.tipo_documento_concurso SET id_genero=2 WHERE genero = 'M';

UPDATE concurso.candidato_aprovado SET id_genero = 4 WHERE id_genero IS NULL AND sexo IS NULL;
