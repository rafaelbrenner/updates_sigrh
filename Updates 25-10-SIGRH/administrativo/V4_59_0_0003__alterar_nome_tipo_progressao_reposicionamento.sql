-- #450127 - Gerar reposicionamento dos servidores redistribuídos
--Alteração dos nomes do tipo de progressãão de reposicionamento para atender à Medida Provisória Nº 1.286


update rh_tipos.tipo_progressao set denominacao = 'Reposicionamento PCCTAE - Medida Provisória Nº 1.286' where id_tipo_progressao = 20;
update rh_tipos.tipo_progressao set denominacao = 'Reposicionamento na Carreira - Medida Provisória Nº 1.286' where id_tipo_progressao = 19;