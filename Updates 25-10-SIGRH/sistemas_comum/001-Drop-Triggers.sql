--=============================================================================
-- BANCO COMUM
-- Drop das TRIGGERs para evitar erro ao executar os scripts
--=============================================================================


DROP TRIGGER tg_cadastroalteracaoemail_up ON comum.usuario;
DROP TRIGGER tg_cadastroalteracaoemail_up ON comum.pessoa;