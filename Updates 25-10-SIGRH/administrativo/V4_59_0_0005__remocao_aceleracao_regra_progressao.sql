-- #451832 - Remover a opção Aceleração da Progressão para técnicos administrativos (Correção)


UPDATE funcional.factory_regras_progressao SET ids_tipo_progressao = '.6.' WHERE id_factory_regras_progressao = 10;