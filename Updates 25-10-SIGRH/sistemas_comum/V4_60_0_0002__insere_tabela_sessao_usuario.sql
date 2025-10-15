--#453763 - Controle de sessão do usuário
CREATE TABLE IF NOT EXISTS comum.sessao_usuario (
  id int  NOT NULL,      				 -- Identificador da sessão (registro de entrada)
  sessionid VARCHAR(255) NOT NULL,      -- session ID
  login VARCHAR(255),          		  -- Login do usuário
  useragent VARCHAR(255),               -- String do user agent do navegador ou dispositivo
  ip VARCHAR(45),                       -- Endereço IP do usuário
  host VARCHAR(255),                    -- Endereço do host
  sistema int,                 		  -- Sistema que o usuário acessou
  ativo BOOLEAN DEFAULT TRUE,           -- Status da sessão (ativo ou não)
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação da sessão
  PRIMARY KEY (id)               -- Chave primária baseada no registro de entrada
);

ALTER TABLE comum.sessao_usuario OWNER TO comum_group;
GRANT ALL ON TABLE comum.sessao_usuario TO comum_group;
GRANT SELECT ON TABLE comum.sessao_usuario TO readonly_group;