-- #453439 - Criação do módulo governança

CREATE SCHEMA governanca AUTHORIZATION adm_group;

--comite governancia
CREATE TABLE governanca.comite_governanca (
    id_comite_governanca int NOT NULL,
    denominacao varchar(100) NOT NULL,
    sigla varchar(10),
    descricao varchar(400),
    quantidade_membros int,
    ativo BOOLEAN NOT NULL,
    CONSTRAINT pk_comite_governanca PRIMARY KEY (id_comite_governanca)
);
ALTER TABLE governanca.comite_governanca OWNER TO adm_group;

COMMENT ON TABLE governanca.comite_governanca IS 'Informação principal do subsistema de governança.';
COMMENT ON COLUMN governanca.comite_governanca.id_comite_governanca IS 'Chave primária.';
COMMENT ON COLUMN governanca.comite_governanca.denominacao IS 'Nome do Comitê.';
COMMENT ON COLUMN governanca.comite_governanca.sigla IS 'Sigla do Comitê.';
COMMENT ON COLUMN governanca.comite_governanca.descricao IS 'Descrição do comitê, tais como suas atribuições, formação, etc...';
COMMENT ON COLUMN governanca.comite_governanca.quantidade_membros IS 'Quantidade máxima de membros dentro do comitê, entre titulares e suplentes.';

CREATE SEQUENCE governanca.comite_governanca_seq;
ALTER SEQUENCE governanca.comite_governanca_seq OWNER TO adm_group;

--arquivo anexo resolucao governanca
CREATE TABLE governanca.arquivo_anexo_resolucao_governanca (
    id_arquivo_anexo_resolucao_governanca int NOT NULL,
    id_resolucao_governanca int NOT NULL,
    id_arquivo int NOT NULL,
    nome varchar(500),
    CONSTRAINT pk_arquivo_anexo_resolucao_governanca PRIMARY KEY (id_arquivo_anexo_resolucao_governanca)

);
ALTER TABLE governanca.arquivo_anexo_resolucao_governanca OWNER TO adm_group;

COMMENT ON TABLE governanca.arquivo_anexo_resolucao_governanca IS 'Representa 1 arquivo anexo de uma dada resolução, informando assim o nome do anexo, a resolução e o id do arquivo';
COMMENT ON COLUMN governanca.arquivo_anexo_resolucao_governanca.id_arquivo_anexo_resolucao_governanca IS 'Chave primária.';
COMMENT ON COLUMN governanca.arquivo_anexo_resolucao_governanca.id_resolucao_governanca IS 'Identificador do arquivo na base arquivos';
COMMENT ON COLUMN governanca.arquivo_anexo_resolucao_governanca.id_arquivo IS 'Referência para qual resolução referem-se os arquivos';
COMMENT ON COLUMN governanca.arquivo_anexo_resolucao_governanca.nome IS 'Título do arquivo que aparece para o usuário';


CREATE SEQUENCE governanca.arquivo_anexo_resolucao_governanca_seq;
ALTER SEQUENCE governanca.arquivo_anexo_resolucao_governanca_seq OWNER TO adm_group;

-- resolucao
CREATE TABLE governanca.resolucao (
    id_resolucao int NOT NULL,
    data_resolucao timestamp NOT NULL,
    numero int NOT NULL,
    id_arquivo int NOT NULL,
    ementa text NOT NULL,
    ementa_ascii text NOT NULL,
    id_comite_governanca int NOT NULL,
    ano int NOT NULL,
    observacao text,
    id_resolucao_revogante int,
    digito bpchar(1),
    id_tipo_resolucao int NOT NULL,
    CONSTRAINT id_resolucao_governanca_pkey PRIMARY KEY (id_resolucao),
	CONSTRAINT fk_id_comite_governanca FOREIGN KEY (id_comite_governanca) REFERENCES governanca.comite_governanca (id_comite_governanca)
);
ALTER TABLE governanca.resolucao OWNER TO adm_group;

COMMENT ON TABLE governanca.resolucao IS 'Entidade para realizar a identificação das modificações (revogar, alterar, etc) que uma determinada resolução realiza sobre resoluções já existentes.';
COMMENT ON COLUMN governanca.resolucao.id_resolucao IS 'Chave primária.';
COMMENT ON COLUMN governanca.resolucao.data_resolucao IS 'Data da resolução.';
COMMENT ON COLUMN governanca.resolucao.numero IS 'Numero da resolução.';
COMMENT ON COLUMN governanca.resolucao.id_arquivo IS 'Identificador do arquivo que representa a resolução.';
COMMENT ON COLUMN governanca.resolucao.ementa IS 'Ementa (resumo) da resolução.';
COMMENT ON COLUMN governanca.resolucao.ementa_ascii IS 'Campo da Ementa em ASCII para realizar buscas não sensiveis a acentuações. ';
COMMENT ON COLUMN governanca.resolucao.id_comite_governanca IS 'Identificador do comitê ao qual a resolução está vinculada';
COMMENT ON COLUMN governanca.resolucao.ano IS 'Ano em que foi criada a resolução.';
COMMENT ON COLUMN governanca.resolucao.observacao IS 'Observações acerca de resolução publicada.';
COMMENT ON COLUMN governanca.resolucao.id_resolucao_revogante IS 'Este campo armazena a resolução revogada. Quando uma resolução é publicada que revoga outra resolução ele é usado.';
COMMENT ON COLUMN governanca.resolucao.digito IS 'Campo que compõe o unicidade da resolução.';
COMMENT ON COLUMN governanca.resolucao.id_tipo_resolucao IS 'Identificador do tipo de resolução';


CREATE SEQUENCE governanca.resolucao_seq;
ALTER SEQUENCE governanca.resolucao_seq OWNER TO adm_group;


--tipo resolucao
CREATE TABLE governanca.tipo_resolucao (
    id_tipo_resolucao int NOT NULL,
    denominacao varchar(50) NOT NULL,
    CONSTRAINT id_tipo_resolucao_governanca_pkey PRIMARY KEY (id_tipo_resolucao)
);
ALTER TABLE governanca.tipo_resolucao OWNER TO adm_group;

COMMENT ON TABLE governanca.tipo_resolucao IS 'Tabela que relaciona os tipos de resoluções de colegiados.';
COMMENT ON COLUMN governanca.tipo_resolucao.id_tipo_resolucao IS 'Chave primária.';
COMMENT ON COLUMN governanca.tipo_resolucao.denominacao IS 'Denominação do tipo da resolução.';


CREATE SEQUENCE governanca.tipo_resolucao_seq;
ALTER SEQUENCE governanca.tipo_resolucao_seq OWNER TO adm_group;

--inserindo tipos de resolucao
INSERT INTO governanca.tipo_resolucao (id_tipo_resolucao, denominacao) VALUES(1, 'Deliberativa');
INSERT INTO governanca.tipo_resolucao (id_tipo_resolucao, denominacao) VALUES(2, 'Normativa');