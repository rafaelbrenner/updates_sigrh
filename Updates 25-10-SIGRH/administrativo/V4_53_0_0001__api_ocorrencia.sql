--Manual

--#319362 - Cliente para consumir Web Service de Afastamento no Archanjo
--Fazer a associa��o das ocorr�ncias que dever�o ser sincronizadas com a API. Buscar a ocorr�ncia pela descri��o e substituir o id correspondente.
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 1 WHERE id_ocorrencia = X; -- Ocorr�ncia - Falta justificada
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 4 WHERE id_ocorrencia = Y; -- Ocorr�ncia - Comparecimento a ato e proc judicial/ procedimento administrativo
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 5 WHERE id_ocorrencia = Z; -- Ocorr�ncia - Atividade com gratifica��o por encargo de curso e concurso
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 6 WHERE id_ocorrencia = W; -- Ocorr�ncia - Participa��o em atividade sindical
--UPDATE funcional.ocorrencia SET id_ocorrencia_api = 7 WHERE id_ocorrencia = K; -- Ocorr�ncia - Declara��o de comparecimento ao m�dico
