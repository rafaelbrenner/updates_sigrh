-- #422752 - Adição novos campos na ficha de incrição

-- Cria a sequence para a chave primária da tabela 'concurso.cota_concorrencia_concurso'
CREATE SEQUENCE concurso.cota_concorrencia_concurso_seq
    INCREMENT 1
    START 1;

ALTER SEQUENCE IF EXISTS concurso.cota_concorrencia_concurso_seq
    OWNER TO adm_group;
    
COMMENT ON SEQUENCE concurso.cota_concorrencia_concurso_seq
    IS 'Sequence para a geração de sequências para a chave primária da tabela  "concurso.cota_concorrencia_concurso".';   
    

-- Cria a Tabela que representa a notificação de turmas de capacitação
   
CREATE TABLE concurso.cota_concorrencia_concurso
(
    id_cota_concorrencia_concurso integer NOT NULL,
    id_inscricao_candidato integer NOT NULL,
    tipo_concorrencia varchar not null,
    id_arquivo integer,
    CONSTRAINT cota_concorrencia_concurso_pkey PRIMARY KEY (id_cota_concorrencia_concurso),
    CONSTRAINT cota_concorrencia_concurso_id_inscricao_candidato_fkey FOREIGN KEY (id_inscricao_candidato)
        REFERENCES concurso.inscricao_candidato (id_inscricao_candidato) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);


ALTER TABLE IF EXISTS concurso.cota_concorrencia_concurso
    OWNER to adm_group;
GRANT ALL ON TABLE concurso.cota_concorrencia_concurso TO adm_group;

COMMENT ON TABLE concurso.cota_concorrencia_concurso
    IS 'Tabela que armazena as informações das cotas de uma inscrição de concurso.';

COMMENT ON COLUMN concurso.cota_concorrencia_concurso.id_cota_concorrencia_concurso
    IS 'Chave primária da tabela.'; 

COMMENT ON COLUMN concurso.cota_concorrencia_concurso.id_inscricao_candidato
    IS 'Chave estrangeira que relaciona a inscrição que esta associada ao registro.';

COMMENT ON COLUMN concurso.cota_concorrencia_concurso.tipo_concorrencia
    IS 'Tipo de cota para qual o candidato se inscreveu.';

COMMENT ON COLUMN concurso.cota_concorrencia_concurso.id_arquivo
    IS 'Arquivo relacionado como comprovante da cota.';

insert into concurso.cota_concorrencia_concurso (id_cota_concorrencia_concurso,id_inscricao_candidato,tipo_concorrencia) (
	select nextval('concurso.cota_concorrencia_concurso_seq'),id_inscricao_candidato,'COTAS_NEGROS' from concurso.inscricao_candidato ic where ic.lei_de_cotas);   

alter table concurso.inscricao_candidato add column id_arquivo_comprov_deficiencia integer;
COMMENT ON COLUMN concurso.inscricao_candidato.id_arquivo_comprov_deficiencia IS 'Arquivo relacionado como comprovante de deficiência.';
