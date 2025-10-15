-- #419729 - Parametrização da URL do manual do servidor.

/**
 * O seguinte script atualiza o parâmetro do manual do servidor para a URL interna do projeto SIGRH.
 */

UPDATE comum.parametro 
SET valor = 'documentos/manual_servidor/index.htm?aba=p-documentos'
WHERE codigo = '7_100000_12';