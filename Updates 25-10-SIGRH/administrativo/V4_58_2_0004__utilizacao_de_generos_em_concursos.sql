-- #431120 - CRIAÇÃO DO CAMPO IDENTIDADE DE GÊNERO

-- Cria e atualiza as informações para novos gêneros

ALTER TABLE comum.genero ADD COLUMN IF NOT EXISTS descricao_ingles varchar; 
COMMENT ON COLUMN comum.genero.descricao_ingles IS 'Tradução da descrição a ser usada na internacionalização.';

ALTER TABLE comum.genero ADD COLUMN IF NOT EXISTS outro boolean NOT NULL DEFAULT FALSE; 
COMMENT ON COLUMN comum.genero.outro IS 'Identifica se o gênero é considerado como parte da opção "Outro"';


INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(5, 'Mulher transgênero (não se identifica com o gênero socialmente atribuído no nascimento)', 'Transgender woman (does not identify with the gender socially assigned at birth)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(6, 'Mulher travesti (identidade de gênero feminina diferente do gênero socialmente atribuído no nascimento)', 'Transvestite woman (female gender identity different from the gender socially assigned at birth)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(7, 'Homem transgênero (não se identifica com o gênero socialmente atribuído no nascimento)', 'Transgender man (does not identify with the gender socially assigned at birth)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(8, 'Pessoa não-binária (não se identifica com o gênero masculino ou com o feminino)', 'Non-binary person (does not identify with the male or female gender)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(9, 'Pessoa de gênero fluido (identidade de gênero que transita entre diferentes gêneros)', 'Gender-fluid person (gender identity who changes over time)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(10, 'Agênero (não se identifica com qualquer gênero, seja esse binário ou não-binário)', 'Agender (does not identify with any gender, whether binary or non-binary)', true) ON CONFLICT DO NOTHING;
INSERT INTO comum.genero (id_genero, descricao, descricao_ingles, outro) VALUES(11, 'Outra identidade de gênero', 'Other gender identity', true) ON CONFLICT DO NOTHING;

SELECT setval('comum.genero_seq', max(id_genero)) FROM comum.genero;

UPDATE comum.genero SET descricao_ingles = 'Another' WHERE id_genero = 1;
UPDATE comum.genero SET descricao_ingles = 'Male' WHERE id_genero = 2;
UPDATE comum.genero SET descricao_ingles = 'Female' WHERE id_genero = 3;
UPDATE comum.genero SET descricao_ingles = 'I would rather not tell', outro = TRUE WHERE id_genero = 4;


ALTER TABLE concurso.pessoa_candidato ADD COLUMN IF NOT EXISTS id_genero INTEGER;
COMMENT ON COLUMN concurso.pessoa_candidato.id_genero IS 'Identificador do gênero do candidato.';
ALTER TABLE concurso.pessoa_candidato ADD CONSTRAINT pessoa_candidato_genero_fk FOREIGN KEY (id_genero) REFERENCES comum.genero(id_genero);


ALTER TABLE concurso.inscricao_candidato ADD COLUMN IF NOT EXISTS id_genero INTEGER;
COMMENT ON COLUMN concurso.inscricao_candidato.id_genero IS 'Identificador do gênero do candidato.';
ALTER TABLE concurso.inscricao_candidato ADD CONSTRAINT inscricao_candidato_genero_fk FOREIGN KEY (id_genero) REFERENCES comum.genero(id_genero);


ALTER TABLE concurso.candidato_aprovado ADD COLUMN IF NOT EXISTS id_genero INTEGER;
COMMENT ON COLUMN concurso.candidato_aprovado.id_genero IS 'Identificador do gênero do candidato.';
ALTER TABLE concurso.candidato_aprovado ADD CONSTRAINT candidato_aprovado_genero_fk FOREIGN KEY (id_genero) REFERENCES comum.genero(id_genero);

ALTER TABLE comum.genero ALTER COLUMN descricao_ingles SET NOT NULL;


-- Migra a informação de sexo para gênero nas tabelas concurso.pessoa_candidato, concurso.inscricao_candidato, concurso.candidato_aprovado e comum.pessoa.
UPDATE concurso.pessoa_candidato SET id_genero = 2 WHERE sexo = 'M';
UPDATE concurso.pessoa_candidato SET id_genero = 3 WHERE sexo = 'F';

UPDATE concurso.inscricao_candidato SET id_genero = 2 WHERE sexo = 'M';
UPDATE concurso.inscricao_candidato SET id_genero = 3 WHERE sexo = 'F';

UPDATE concurso.candidato_aprovado SET id_genero = 2 WHERE sexo = 'M';
UPDATE concurso.candidato_aprovado SET id_genero = 3 WHERE sexo = 'F';

UPDATE comum.pessoa SET id_genero = 2 WHERE sexo = 'M' AND id_genero IS NULL;
UPDATE comum.pessoa SET id_genero = 3 WHERE sexo = 'F' AND id_genero IS NULL;
UPDATE comum.pessoa SET id_genero = 4 WHERE sexo = 'N' AND id_genero IS NULL;
