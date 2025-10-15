#!/bin/bash

#ENTRADA_AMBIENTE
while [ true ]
do
	#AMBIENTE QUE SERA EXECUTADO SCRIPT
	read -p 'AMBIENTE QUE SERÁ FEITO ATUALIZAÇÃO (1 : local, 2: desenv, 3: treinamento, 4: homologa e 5: producao): ' escolhaAmbiente
	echo
	#SCRIPT PARA INFORMAR O IP DOS BANCOS E NOME DOS AMBIENTES
	case $escolhaAmbiente in 
		1)
			ambiente='LOCAL'
			host_execucao=localhost
			break
			;;
		2)
			ambiente='DESENV'
			host_execucao=164.41.103.55
			break
			;;
		3) 
			ambiente='TREINAMENTO'
			host_execucao=164.41.103.68
			sufixo='_treinamento'
			break
			;;
		4)
			ambiente='HOMOLOGA'
			host_execucao=164.41.103.68
			break
			;;
		5)
			ambiente='PRODUCAO'
			host_execucao=164.41.107.147
			break
			;; 
		*)
			#ERRO_ENTRADA_AMBIENTE
			clear
			echo ESCOLHA UM NÚMERO VÁLIDO PARA O AMBIENTE DE BACKUP
			continue
			;;
	esac
done

#USER DO BANCO
read -p "Usuário do banco do ambiente ${ambiente}: " userBanco
#SENHA DO USER DO BANCO
read -s -p "Senha do banco do ambiente ${ambiente}: " senhaBanco
echo
export PGPASSWORD="$senhaBanco"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for database in *; do
	if [ -d ${database} ]; then
		for filename in ${database}/*.sql; do
			echo
			echo
			echo DATABASE QUE SERÁ ATUALIZADO: ${database}
			set -x
			echo =========================================  PROCESSANDO ARQUIVO $filename.  =========================================
			echo
			psql -h "${host_execucao}" -p 5432 -U "${userBanco}" -v ON_ERROR_STOP=1 -d "${database}${sufixo}" -e -f "${filename}"
			{ result=$?; } 2>/dev/null
			{ set +x; } 2>/dev/null
			if [ $result -ne 0 ]
			then
				echo =========================================
				echo =========================================
				echo =========================================  ARQUIVO $filename GEROU ERRO NA EXECUCAO. VERIFICAR.
				echo =========================================  
				echo =========================================  
				echo
				exit 1
			fi
		done
	fi
done
IFS=$SAVEIFS

echo PROCEDIMENTO FINALIZADO
