-- #446776 - Criação de coluna para identificar necessidades especiais que caracterizam PCD.

ALTER TABLE comum.tipo_necessidade_especial ADD COLUMN IF NOT EXISTS caracteriza_pcd bool DEFAULT false;
COMMENT ON COLUMN comum.tipo_necessidade_especial.caracteriza_pcd IS 'Indica se o Tipo de Necessidade Especial caracteriza uma pessoa com deficiência.';