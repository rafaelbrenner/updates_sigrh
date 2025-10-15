-- #329990 - Erro vixe em alterar lotação ou exercício
--
--  SCRIPT RODADO NO BANCO ADMINISTRATIVO PARA PEGAR OS LOGINS QUE PRECISAM ATUALIZAR A SENHA NO BANCO ADMINISTRATIVO
--
SELECT '''' || u.login || ''','
FROM comum.pessoa p
JOIN comum.usuario u ON p.id_pessoa = u.id_pessoa
WHERE p.cpf_cnpj IS NOT null
	AND u.senha IS null
ORDER BY u.login;