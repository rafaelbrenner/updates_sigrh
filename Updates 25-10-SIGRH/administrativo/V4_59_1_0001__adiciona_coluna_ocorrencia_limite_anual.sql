-- #451334 - Criar campo Limite Anual no cadastro de tipo de ocorrência

alter table funcional.ocorrencia add column if not exists limite_anual integer;
comment on column funcional.ocorrencia.limite_anual is 'Define a quantidade máxima de vezes que um servidor pode registrar uma determinada ocorrência dentro do ano civil.';

alter table funcional.configuracao_ocorrencia add column if not exists limite_anual integer;
comment on column funcional.configuracao_ocorrencia.limite_anual is 'Define a quantidade máxima de vezes que um servidor pode registrar uma determinada ocorrência dentro do ano civil.';
