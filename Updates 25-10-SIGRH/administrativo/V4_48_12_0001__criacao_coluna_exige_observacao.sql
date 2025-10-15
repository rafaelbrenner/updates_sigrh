--Manual
--#344419 - Criação de campo em Ocorrência para determinar obrigatoriedade do campo Observação ao se informar ausência
--ALTER TABLE funcional.ocorrencia ADD COLUMN exige_observacao BOOLEAN NOT NULL DEFAULT TRUE;

--UPDATE funcional.ocorrencia SET exige_observacao = false WHERE id_ocorrencia IN (	
--    SELECT DISTINCT ago.id_ocorrencia AS id_ocorrencia 
--    FROM funcional.associacao_grupo_ocorrencia ago
--    JOIN funcional.grupo_ocorrencia go ON go.id_grupo_ocorrencia = ago.id_grupo_ocorrencia 
--    WHERE go.exige_doc_legal = true);
