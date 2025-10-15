-- #440202 - Altera coluna classe_funcional da homologacao das vagas para nao nulo.

ALTER TABLE concurso.area_contratacao_homologada ALTER COLUMN id_classe_funcional DROP NOT NULL;

