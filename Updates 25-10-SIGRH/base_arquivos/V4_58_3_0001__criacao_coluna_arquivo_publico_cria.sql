--#396114 - Nova coluna no banco de SUSTENTAÇÃO de arquivos.
--#390453 - Modificação na manipulação de arquivos

-- Criação de coluna no banco "base_arquivos".
--alter table arquivos add publico bool default bool(false) not null;
--comment on column arquivos.publico is 'Indica se um arquivo e publico ou nao.';
