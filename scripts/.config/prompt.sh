# Prompt dividido com branch Git

# Função auxiliar para obter o nome do branch atual do Git
# Retorna o nome do branch ou nada se não estiver em um repositório
parse_git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null
}

# Define o prompt PS1
# Linha 1: usuário@host em verde negrito + hora em amarelo
# Linha 2: caminho em azul negrito + branch em amarelo (se houver)
# Exibe o símbolo do prompt no final
PS1='\[\e[1;32m\]\u@\h \[\e[0;33m\]\A\[\e[0m\]\n'                              # linha 1
PS1+=' \[\e[1;34m\]\w\[\e[0m\]'                                               # linha 2: caminho
PS1+='$(branch=$(parse_git_branch); [[ $branch ]] && echo " \[\e[33m\]($branch)\[\e[0m\]")'  # branch
PS1+=' \$ '                                                                   # símbolo $
