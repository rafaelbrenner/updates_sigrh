@ECHO OFF

CHCP 1252

:ENTRADA_AMBIENTE
::AMBIENTE QUE SERA EXECUTADO SCRIPT
SET /P escolhaAmbiente="AMBIENTE QUE SER� FEITO ATUALIZA��O (1 : local, 2: desenv, 3: treinamento, 4: homologa , 5: Desenv-Espec�fico e 6: producao): "
ECHO.
::REM SCRIPT PARA TROCAR OS DIRECIONAMENTOS DO SISTEMA PARA O AMBIENTE CORRETO E INFORMAR O IP DOS BANCOS
IF "%escolhaAmbiente%"=="1" (
	SET ambiente=LOCAL
	SET host_execucao=localhost
	GOTO :CONTINUA
)
IF "%escolhaAmbiente%"=="2" (
	SET ambiente=DESENV
	SET host_execucao=164.41.103.55
	GOTO :CONTINUA
)
IF "%escolhaAmbiente%"=="3" (
	SET ambiente=TREINAMENTO
	SET host_execucao=164.41.103.68
	SET sufixo=_treinamento
	GOTO :CONTINUA
)
IF "%escolhaAmbiente%"=="4" (
	SET ambiente=HOMOLOGA
	SET host_execucao=164.41.103.68
	GOTO :CONTINUA
)
IF "%escolhaAmbiente%"=="5" (
	SET ambiente=ATUALIZACAO
	SET host_execucao=164.41.103.55
	::AMBIENTE DE REFERENCIA DO ARQUIVO DE BACKUP (Digitar exatamente como aparece, ex.: prod, hml, prd)
	SET /P amb_ref="Digite o dia (2 d�gitos): "
	::DIA DE REFERENCIA DO ARQUIVO DE BACKUP
	SET /P dia_ref="Digite o dia (2 d�gitos): "
	::MES DE REFERENCIA DO ARQUIVO DE BACKUP
	SET /P mes_ref="Digite o m�s (3 primeiros caracteres): "
	::ANO DE REFERENCIA DO ARQUIVO DE BACKUP
	SET /P ano_ref="Digite o ano (4 d�gitos): "
	::NOME USU�RIO QUE PEDIU BACKUP (Digitar exatamente como aparece, ex.: andre, alan, igor)
	SET /P user_ref="Digite o dia (2 d�gitos): "
	SET sufixo=_%amb_ref%_%dia_ref%%mes_ref%%ano_ref%_%user_ref%
	ECHO.
	GOTO :CONTINUA
)
IF "%escolhaAmbiente%"=="6" (
	SET ambiente=PRODUCAO
	SET host_execucao=164.41.107.147
	GOTO :CONTINUA
)
 
:ERRO_ENTRADA_AMBIENTE
	CLS
	ECHO ESCOLHA UM N�MERO V�LIDO PARA O AMBIENTE
	GOTO :ENTRADA_AMBIENTE	

 
:CONTINUA
::USER DO BANCO
SET /P userBanco="Usu�rio do banco do ambiente %ambiente%: "
::SENHA DO USER DO BANCO
SET /P senhaBanco="Senha do banco do ambiente %ambiente%: "
ECHO.
SET PGPASSWORD=%senhaBanco%
SETLOCAL EnableDelayedExpansion
SET name=""
::SET /P escolhaConversao="CONVERTER ARQUIVOS? (1 : SIM, 2: N�O): "
::ECHO.
::IF "%escolhaConversao%"=="1" (
::	GOTO :CONVERTER_ARQUIVOS
::)
::IF "%escolhaConversao%"=="2" (
::	GOTO :PULA_CONVERSAO
::)
::
::
:::CONVERTER_ARQUIVOS
::ECHO =========================================  CONVERS�O DOS ARQUIVOS SQL  =========================================
::FOR /D %%G IN (*) DO (
::	MKDIR %%G\temp
::	FOR %%f IN ("%%G\*") DO (
::		IF "%%~xf"==".sql" (	
::			FOR /F "delims=" %%a in ('file -bi "%%f"') do ( SET name=%%a )
::			echo Arquivo a ser convertido: %%f
::			SET encoding=!name:*charset=!
::			SET encoding=!encoding:~1!
::			ECHO Codifica��o do arquivo: !encoding!.
::			IF "%ambiente%"=="LOCAL" (				
::				iconv -f !encoding! -t windows-1252 "%%f" > "%%G\temp\%%~nxf"
::				ECHO Arquivo "%%f" convertido para WIN-1252.
::
::			) ELSE (
::				iconv -f !encoding! -t utf-8 "%%f" > "%%G\temp\%%~nxf"
::				ECHO Arquivo "%%f" convertido para UTF-8.
::			)
::		)
::	)
::	XCOPY ".\%%G\temp" ".\%%G" /Y /Q
::	RMDIR /s /q ".\%%G\temp"
::)
::				
::
:PULA_CONVERSAO
IF NOT "%ambiente%"=="LOCAL" (
	CHCP 65001
)
FOR /D %%G IN (*) DO (
	ECHO.
	ECHO.
	ECHO "DATABASE QUE SER� ATUALIZADO: %%G"
	FOR %%f IN ("%%G\*") DO (
		IF "%%~xf"==".sql" (
			ECHO =========================================  PROCESSANDO ARQUIVO %%f.  =========================================
			ECHO.
			SET PGCLIENTENCODING=win1252
			IF NOT "%ambiente%"=="LOCAL" (
				SET PGCLIENTENCODING=utf-8
			)
				ECHO ON
				psql -h %host_execucao% -p 5432 -U %userBanco% -v ON_ERROR_STOP=1 -d %%G%sufixo% -e -f "%%f"
				@ECHO off
			IF !errorlevel! neq 0 (	
				ECHO =========================================
				ECHO =========================================
				ECHO =========================================  ARQUIVO %%f GEROU ERRO NA EXECUCAO. VERIFICAR.
				ECHO =========================================  
				ECHO =========================================  
				ECHO.
				GOTO :FINAL
			)
		)
	)
)

:FINAL
CHCP 850
ECHO ==================================================================================
ECHO PROCEDIMENTO FINALIZADO
ECHO ==================================================================================
PAUSE