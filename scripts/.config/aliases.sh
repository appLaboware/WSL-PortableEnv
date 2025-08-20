# 1) Navegação rápida
alias ..='cd ..'           # Sobe um nível
alias ...='cd ../..'       # Sobe dois níveis
alias ....='cd ../../..'   # Sobe três níveis
alias .....='cd ../../../..' # Sobe quatro níveis
alias ......='cd ../../../../..' # Sobe cinco níveis
alias .='cd -'             # Volta para o diretório anterior

# 2) Listagem de arquivos
alias ls='ls --color=auto' # ls com cores respeitando LS_COLORS
alias l='ls -lah'          # ls detalhado, arquivos ocultos, tamanhos humanos
alias la='ls -lAh'         # ls detalhado, arquivos ocultos exceto . e ..
alias ll='ls -lh'          # ls detalhado, tamanhos humanos
alias lsa='ls -lah'        # equivalente a l

# 3) Sistema e conveniência
alias _='sudo '            # Atalho para sudo
alias md='mkdir -p'        # mkdir com criacao de pais
alias rd='rmdir'           # rmdir direto
alias cls='clear'          # Limpa terminal
alias chinit='nano ~/.bashrc' # Edita rapidamente o bashrc
alias rninit='source ~/.bashrc' # Recarrega o bashrc

# Limpa cache, historico e encerra a sessao
alias cl='(sudo wsl-cleaner --yes && history -c && history -w) || echo "[cl] erro durante limpeza"; exit'

# 4) grep com cor e filtros padrao
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias egrep='grep -E'
alias fgrep='grep -F'

# 5) Git helpers
alias g='git'
alias ga='git add'
alias gall='git add -A'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcm='git checkout $(git_main_branch)'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gcl='git clone --recurse-submodules'
alias gpr='git pull --rebase'
alias gpf='git push --force-with-lease --force-if-includes'

# 6) Diagnóstico do sistema
alias df='df -h'           # Uso de disco legível
alias du='du -h --max-depth=1' # Uso de disco por diretório
alias free='free -m'       # Memória em MB
