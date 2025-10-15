-- #342718 - impedimento de inabilitar linha de transporte
ALTER TABLE transporte.linha_transporte ADD COLUMN IF NOT EXISTS ativo BOOLEAN NOT NULL DEFAULT true;
