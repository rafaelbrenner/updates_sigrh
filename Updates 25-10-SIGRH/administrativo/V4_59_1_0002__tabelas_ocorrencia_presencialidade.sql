-- #449728 - Ocorrências de Presencialidade

-- Criação da tabela frequencia.arquivo_ocorrencia_presencialidade
CREATE SEQUENCE IF NOT EXISTS frequencia.arquivo_ocorrencias_presencialidade_seq 
START WITH 1
INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS frequencia.arquivo_ocorrencias_presencialidade (
    id_arquivo_ocorrencias_presencialidade INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    matriculas_siape text,
    tipo_processamento_pgd varchar (200) NOT NULL,
    apenas_servidor_homologado BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro TIMESTAMP NOT NULL,
    id_registro_entrada INTEGER NOT NULL,
    id_registro_inativacao INTEGER,
    CONSTRAINT pk_arquivo_ocorrencias_presencialidade PRIMARY KEY (id_arquivo_ocorrencias_presencialidade),
    CONSTRAINT fk_arquivo_ocorrencias_presencialidade_id_registro_entrada FOREIGN KEY (id_registro_entrada) REFERENCES comum.registro_entrada(id_entrada),
    CONSTRAINT fk_arquivo_ocorrencias_presencialidade_id_registro_inativacao FOREIGN KEY (id_registro_inativacao) REFERENCES comum.registro_entrada(id_entrada)
);

COMMENT ON TABLE frequencia.arquivo_ocorrencias_presencialidade IS 'Tabela referente a um arquivo de ocorr?ncias de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.id_arquivo_ocorrencias_presencialidade IS 'Identificador ?nico do registro de ocorr?ncias de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.mes IS 'M?s de refer?ncia do arquivo de ocorr?ncias.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.ano IS 'Ano de refer?ncia do arquivo de ocorr?ncias.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.matriculas_siape IS 'Matr?culas SIAPE dos servidores, separadas por v?rgula, para permitir que o arquivo seja gerado para um grupo espec?fico de servidores.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.tipo_processamento_pgd IS 'Define o tipo de processamento a ser realizado para servidores com ocorr?ncia PGD.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.apenas_servidor_homologado IS 'Define se o processamento do arquivo deve conter apenas servidores com frequ?ncia homologada.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.data_cadastro IS 'Data de cadastro do arquivo no sistema.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.id_registro_entrada IS 'Registro de entrada do usu?rio logado no momento do cadastro do arquivo.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade.id_registro_inativacao IS 'Registro de entrada do usu?rio logado no momento da inativa??o do arquivo.';



-- Cria??o da tabela frequencia.arquivo_ocorrencias_presencialidade_item
CREATE SEQUENCE IF NOT EXISTS frequencia.arquivo_ocorrencias_presencialidade_item_seq
START WITH 1
INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS frequencia.arquivo_ocorrencias_presencialidade_item (
    id_arquivo_ocorrencias_presencialidade_item INTEGER NOT NULL,
    id_arquivo_ocorrencias_presencialidade INTEGER NOT NULL,
    id_servidor INTEGER NOT NULL,
    tipo_ocorrencia VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    diploma_legal VARCHAR(255),
    numero_diploma_legal INTEGER,
    data_publicacao_diploma DATE,
    efeito_financeiro BOOLEAN DEFAULT TRUE,
    quantidade_horas TIMESTAMP,
    CONSTRAINT pk_arquivo_ocorrencias_presencialidade_item PRIMARY KEY (id_arquivo_ocorrencias_presencialidade_item),
    CONSTRAINT fk_arquivo_ocorrencias_presencialidade_item_id_arquivo_ocorrencias_presencialidade FOREIGN KEY (id_arquivo_ocorrencias_presencialidade) REFERENCES frequencia.arquivo_ocorrencias_presencialidade(id_arquivo_ocorrencias_presencialidade),
    CONSTRAINT fk_arquivo_ocorrencias_presencialidade_item_id_servidor FOREIGN KEY (id_servidor) REFERENCES rh.servidor(id_servidor)
);

-- Coment?rios para as colunas da tabela
COMMENT ON TABLE frequencia.arquivo_ocorrencias_presencialidade IS 'Tabela referente um item de ocorr?ncia de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.id_arquivo_ocorrencias_presencialidade_item IS 'Identificador ?nico do item de ocorr?ncia de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.id_arquivo_ocorrencias_presencialidade IS 'Identificador do arquivo de ocorr?ncias de presencialidade a que este item pertence.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.id_servidor IS 'Identificador do servidor que possui a presencialidade registrada.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.tipo_ocorrencia IS 'C?digo da ocorr?ncia registrada. Este campo utiliza a enumera??o TipoOcorrencia.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.data_inicio IS 'Data inicial da ocorr?ncia de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.data_fim IS 'Data final da ocorr?ncia de presencialidade.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.diploma_legal IS 'Tipo do diploma legal associado ? ocorr?ncia, se houver.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.numero_diploma_legal IS 'N?mero do diploma legal, que ? obrigat?rio quando um diploma legal ? informado.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.data_publicacao_diploma IS 'Data de publica??o do diploma legal. Este campo ? obrigat?rio quando um diploma legal ? informado.';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.efeito_financeiro IS 'Indica se a ocorr?ncia gera efeito financeiro. O padr?o ? verdadeiro (sim).';
COMMENT ON COLUMN frequencia.arquivo_ocorrencias_presencialidade_item.quantidade_horas IS 'Quantidade de horas registradas para a ocorr?ncia. Este campo deve ser mantido em branco para o caso de trabalho presencial.';


ALTER TABLE frequencia.arquivo_ocorrencias_presencialidade OWNER TO adm_group;  
ALTER TABLE frequencia.arquivo_ocorrencias_presencialidade_item OWNER TO adm_group;  
ALTER SEQUENCE frequencia.arquivo_ocorrencias_presencialidade_seq OWNER TO adm_group;
ALTER SEQUENCE frequencia.arquivo_ocorrencias_presencialidade_item_seq OWNER TO adm_group;