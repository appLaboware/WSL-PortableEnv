# Configura tamanho do histórico em memória e em arquivo
HISTSIZE=50000            # Máximo de comandos em memória
HISTFILESIZE=100000       # Máximo de comandos no arquivo ~/.bash_history

# Formato do timestamp do histórico
HISTTIMEFORMAT='%F %T '   # Exemplo: 2025-06-29 16:45 comando

# Controla duplicação no histórico
# ignoredups = ignora comando duplicado consecutivo
# erasedups  = remove entradas duplicadas no arquivo
HISTCONTROL=ignoredups:erasedups

# Faz append no histórico do arquivo em vez de sobrescrever
shopt -s histappend

# Salva cada comando imediatamente no arquivo do histórico,
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND:-true}"
