--Manual

--#367447 - Ajuste para sincroniza��o em lote
--Fazer a associa��o dos campos obriga�rios das ocorr�ncias que dever�o ser sincronizadas em lote com a API. Verificar se o id corresponde a mesma ocorr�ncia.
--UPDATE funcional.ocorrencia_api SET campos_obrigatorios = 'INICIO,HORAS' WHERE id_ocorrencia_api = 1; -- Ocorr�ncia - Falta justificada 
--UPDATE funcional.ocorrencia_api SET campos_obrigatorios = 'INICIO,TERMINO' WHERE id_ocorrencia_api = 4; -- Ocorr�ncia - Comparecimento a ato e proc judicial/ procedimento administrativo
--UPDATE funcional.ocorrencia_api SET campos_obrigatorios = 'INICIO,HORAS' WHERE id_ocorrencia_api = 5; -- Ocorr�ncia - Atividade com gratifica��o por encargo de curso e concurso
--UPDATE funcional.ocorrencia_api SET campos_obrigatorios = 'INICIO,HORAS' WHERE id_ocorrencia_api = 6; -- Ocorr�ncia - Participa��o em atividade sindical
--UPDATE funcional.ocorrencia_api SET campos_obrigatorios = 'INICIO,HORAS' WHERE id_ocorrencia_api = 7; -- Ocorr�ncia - Declara��o de comparecimento ao m�dico
