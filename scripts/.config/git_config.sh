# 1) Git via SSH sempre
# Define o comando SSH padrão para o GitHub, usando chave específica
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes'

# Redireciona URLs HTTPS para SSH no GitHub (configuração persistente)
# Isso evita ter que alterar URLs de repositórios manualmente
if ! git config --global --get url."git@github.com:".insteadOf >/dev/null; then
  git config --global url."git@github.com:".insteadOf "https://github.com/"
fi

# 2) ssh-agent automático
# Inicializa o ssh-agent e adiciona a chave padrão silenciosamente
if [[ -z $SSH_AUTH_SOCK ]]; then
  eval $(ssh-agent -s) >/dev/null
  ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# 3) Git Aliases
# Aliases para comandos Git comuns para agilidade
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
alias gcom='gall && gc'
