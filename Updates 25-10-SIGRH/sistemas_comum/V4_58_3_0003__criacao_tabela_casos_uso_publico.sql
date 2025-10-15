
--Criação da tabela de caso de uso público
CREATE TABLE IF NOT EXISTS comum.caso_uso_publico (
	id_caso_uso_publico INTEGER NOT null,
	codigo VARCHAR(255),
	nome VARCHAR(255) NOT null,
	descricao VARCHAR(255) NOT null,
	link VARCHAR(255) NOT null,
	id_sistema INTEGER NOT null,
	id_sub_sistema INTEGER NOT null,
	CONSTRAINT caso_uso_publico_pkey PRIMARY KEY (id_caso_uso_publico),
	CONSTRAINT caso_uso_publico_id_sistema_fkey FOREIGN KEY (id_sistema) REFERENCES comum.sistema (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT caso_uso_publico_id_sub_sistema_fkey FOREIGN KEY (id_sub_sistema) REFERENCES comum.subsistema (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);
ALTER TABLE comum.caso_uso_publico OWNER TO comum_group;
GRANT ALL ON TABLE comum.caso_uso_publico TO comum_group;
GRANT SELECT ON TABLE comum.caso_uso_publico TO readonly_group;

CREATE SEQUENCE IF NOT EXISTS comum.caso_uso_publico_seq
   INCREMENT 1
   START 1;
ALTER SEQUENCE comum.caso_uso_publico_seq
  OWNER TO comum_group;
COMMENT ON SEQUENCE comum.caso_uso_publico_seq
  IS 'Gerador de Sequкncia para a chave primária da tabela comum.caso_uso_publico';
  
 
COMMENT ON COLUMN comum.caso_uso_publico.id_caso_uso_publico IS 'Identificador do caso de uso';
COMMENT ON COLUMN comum.caso_uso_publico.codigo IS 'Codigo para identificação do caso de uso';
COMMENT ON COLUMN comum.caso_uso_publico.nome IS 'Nome para referenciar o caso de uso';
COMMENT ON COLUMN comum.caso_uso_publico.descricao IS 'Descrição do caso de uso e suas funcionalidades';
COMMENT ON COLUMN comum.caso_uso_publico.link IS 'Caminho para acesso do caso de uso';
COMMENT ON COLUMN comum.caso_uso_publico.id_sistema IS 'Identificador do sistema responsável pelo caso de uso';
COMMENT ON COLUMN comum.caso_uso_publico.id_sub_sistema IS 'Identificador do sub sistema responsável pelo caso de uso';
COMMENT ON TABLE comum.caso_uso_publico  IS 'Tabela utilizada para representar os casos de uso implementados nos sistemas.';

