-- #449728 - Ocorrências de Presencialidade

INSERT INTO funcional.grupo_ocorrencia
(id_grupo_ocorrencia, id_tipo_origem, denominacao, correspondencia_siape, codigo_siape, nao_excluir, codigo_sigrh)
VALUES(nextval('funcional.grupo_ocorrencia_seq'), 6, 'OCORRÊNCIAS DE PRESENCIALIDADE', false, NULL, true, 10037);

INSERT INTO funcional.grupo_ocorrencia
(id_grupo_ocorrencia, id_tipo_origem, denominacao, correspondencia_siape, codigo_siape, nao_excluir, codigo_sigrh)
VALUES(nextval('funcional.grupo_ocorrencia_seq'), 6, 'OCORRÊNCIAS PGD', false, NULL, true, 10038);