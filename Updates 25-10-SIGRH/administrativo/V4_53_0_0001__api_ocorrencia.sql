--Manual

--#319362 - Cliente para consumir Web Service de Afastamento no Archanjo
--Fazer a associação das ocorrências que deverão ser sincronizadas com a API. Buscar a ocorrência pela descrição e substituir o id correspondente.
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 1 WHERE id_ocorrencia = X; -- Ocorrência - Falta justificada
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 4 WHERE id_ocorrencia = Y; -- Ocorrência - Comparecimento a ato e proc judicial/ procedimento administrativo
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 5 WHERE id_ocorrencia = Z; -- Ocorrência - Atividade com gratificação por encargo de curso e concurso
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 6 WHERE id_ocorrencia = W; -- Ocorrência - Participação em atividade sindical
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 7 WHERE id_ocorrencia = K; -- Ocorrência - Declaração de comparecimento ao médico
