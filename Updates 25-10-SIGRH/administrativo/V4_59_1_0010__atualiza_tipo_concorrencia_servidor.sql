-- #455552 - CI ao detalhar concursos com servidor docente nomeado
update rh.servidor set tipo_concorrencia = 'AMPLA_CONCORRENCIA' where tipo_concorrencia = 'PADRAO';