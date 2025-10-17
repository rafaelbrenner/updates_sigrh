#!/bin/bash
#=============================================================================
# SCRIPT DE VERIFICAÇÃO - ATUALIZAÇÕES SIGRH
# Verifica se todas as alterações dos scripts SQL foram aplicadas no banco
#=============================================================================

set -e  # Parar em caso de erro

#=============================================================================
# CONFIGURAÇÕES DO BANCO DE DADOS
#=============================================================================

# Configurações de conexão - AJUSTE CONFORME SEU AMBIENTE
DB_HOST="164.41.103.55"
DB_PORT="5432"
DB_NAME="administrativo"
DB_USER="rafael.brenner"
DB_PASSWORD="R@lyne10"

# Caminhos
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERIFY_SQL_FILE="${SCRIPT_DIR}/verify_updates.sql"
LOG_FILE="${SCRIPT_DIR}/verificacao_$(date +%Y%m%d_%H%M%S).log"

#=============================================================================
# CORES PARA OUTPUT
#=============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

#=============================================================================
# FUNÇÕES AUXILIARES
#=============================================================================

write_log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_message="[$timestamp] [$level] $message"
    
    # Escrever no console com cores
    case "$level" in
        "SUCCESS")
            echo -e "${GREEN}${log_message}${NC}"
            ;;
        "ERROR")
            echo -e "${RED}${log_message}${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}${log_message}${NC}"
            ;;
        "INFO")
            echo -e "${CYAN}${log_message}${NC}"
            ;;
        *)
            echo "$log_message"
            ;;
    esac
    
    # Escrever no arquivo de log
    echo "$log_message" >> "$LOG_FILE"
}

test_postgresql_connection() {
    export PGPASSWORD="$DB_PASSWORD"
    
    if psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1;" > /dev/null 2>&1; then
        unset PGPASSWORD
        return 0
    else
        unset PGPASSWORD
        return 1
    fi
}

execute_verification_sql() {
    local sql_file="$1"
    
    write_log "Executando verificações do arquivo: $sql_file" "INFO"
    
    # Definir senha como variável de ambiente
    export PGPASSWORD="$DB_PASSWORD"
    
    # Executar o arquivo SQL e capturar a saída
    local output
    if output=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$sql_file" 2>&1); then
        unset PGPASSWORD
        write_log "Verificações executadas com sucesso!" "SUCCESS"
        echo "$output"
        return 0
    else
        local exit_code=$?
        unset PGPASSWORD
        write_log "Erro ao executar verificações. Código: $exit_code" "ERROR"
        echo "$output"
        return 1
    fi
}

parse_verification_results() {
    local output="$1"
    local success_count=0
    local error_count=0
    local warning_count=0
    
    write_log "" "INFO"
    write_log "========================================" "INFO"
    write_log "RESULTADOS DA VERIFICAÇÃO" "INFO"
    write_log "========================================" "INFO"
    write_log "" "INFO"
    
    # Processar cada linha da saída
    while IFS= read -r line; do
        line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        
        if [[ "$line" =~ "✓ OK" ]]; then
            write_log "$line" "SUCCESS"
            ((success_count++))
        elif [[ "$line" =~ "✗ ERRO" ]]; then
            write_log "$line" "ERROR"
            ((error_count++))
        elif [[ "$line" =~ "⚠ AVISO" ]] || [[ "$line" =~ "⚠ PARCIAL" ]]; then
            write_log "$line" "WARNING"
            ((warning_count++))
        elif [[ "$line" =~ "verificacao|status|categoria|titulo" ]] && [[ -n "$line" ]]; then
            write_log "$line" "INFO"
        fi
    done <<< "$output"
    
    write_log "" "INFO"
    write_log "========================================" "INFO"
    write_log "RESUMO FINAL" "INFO"
    write_log "========================================" "INFO"
    write_log "✓ Verificações OK: $success_count" "SUCCESS"
    write_log "✗ Erros encontrados: $error_count" "ERROR"
    write_log "⚠ Avisos: $warning_count" "WARNING"
    write_log "========================================" "INFO"
    write_log "" "INFO"
    
    # Retornar 0 se não houver erros, 1 caso contrário
    if [ $error_count -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

show_banner() {
    cat << "EOF"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║           VERIFICAÇÃO DE ATUALIZAÇÕES - SIGRH                  ║.
║                                                                ║
║  Script de verificação das alterações aplicadas no banco      ║
EOF
    echo "║  Data: $(date '+%d/%m/%Y %H:%M:%S')                            ║"
    cat << "EOF"
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
EOF
}

#=============================================================================
# SCRIPT PRINCIPAL
#=============================================================================

main() {
    # Limpar console
    clear
    
    # Mostrar banner
    echo -e "${CYAN}"
    show_banner
    echo -e "${NC}"
    
    # Iniciar log
    write_log "Iniciando verificação das atualizações do SIGRH" "INFO"
    write_log "Arquivo de log: $LOG_FILE" "INFO"
    
    # Verificar se o arquivo SQL existe
    if [ ! -f "$VERIFY_SQL_FILE" ]; then
        write_log "ERRO: Arquivo SQL de verificação não encontrado: $VERIFY_SQL_FILE" "ERROR"
        write_log "Certifique-se de que o arquivo 'verify_updates.sql' está no mesmo diretório do script." "ERROR"
        exit 1
    fi
    
    write_log "Arquivo SQL encontrado: $VERIFY_SQL_FILE" "SUCCESS"
    
    # Verificar se psql está instalado
    if ! command -v psql &> /dev/null; then
        write_log "ERRO: psql não está instalado ou não está no PATH" "ERROR"
        write_log "Instale o PostgreSQL client: sudo apt-get install postgresql-client" "ERROR"
        exit 1
    fi
    
    # Verificar conectividade com PostgreSQL
    write_log "Testando conexão com PostgreSQL..." "INFO"
    write_log "Host: $DB_HOST | Porta: $DB_PORT | Banco: $DB_NAME | Usuário: $DB_USER" "INFO"
    
    if ! test_postgresql_connection; then
        write_log "ERRO: Não foi possível conectar ao banco de dados PostgreSQL" "ERROR"
        write_log "Verifique as configurações de conexão no início do script" "ERROR"
        exit 1
    fi
    
    write_log "Conexão estabelecida com sucesso!" "SUCCESS"
    
    # Executar verificações
    write_log "" "INFO"
    write_log "Executando verificações no banco de dados..." "INFO"
    
    if output=$(execute_verification_sql "$VERIFY_SQL_FILE"); then
        # Processar e exibir resultados
        if parse_verification_results "$output"; then
            write_log "" "INFO"
            write_log "✓ TODAS AS VERIFICAÇÕES FORAM CONCLUÍDAS COM SUCESSO!" "SUCCESS"
            write_log "O banco de dados está atualizado corretamente." "SUCCESS"
            exit_code=0
        else
            write_log "" "INFO"
            write_log "✗ FORAM ENCONTRADOS ERROS NAS VERIFICAÇÕES!" "ERROR"
            write_log "Verifique os erros acima e execute os scripts SQL faltantes." "ERROR"
            exit_code=1
        fi
    else
        write_log "" "INFO"
        write_log "ERRO ao executar verificações" "ERROR"
        exit_code=1
    fi
    
    write_log "" "INFO"
    write_log "Verificação finalizada em: $(date '+%d/%m/%Y %H:%M:%S')" "INFO"
    write_log "Log completo salvo em: $LOG_FILE" "INFO"
    
    exit $exit_code
}

# Tratamento de erros
trap 'write_log "Script interrompido!" "ERROR"; exit 1' INT TERM

# Executar função principal
main "$@"