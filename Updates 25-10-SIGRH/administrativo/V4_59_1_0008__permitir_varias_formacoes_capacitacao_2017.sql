-- #393828 - sistema não puxa os certificados que o servidor possui para progredir por capacitação antes de 2018

UPDATE funcional.factory_regras_progressao SET permite_varias_formacoes = TRUE WHERE id_factory_regras_progressao = 1;