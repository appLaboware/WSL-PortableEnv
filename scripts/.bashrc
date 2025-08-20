# ============================================================================
#  .bashrc — perfil definitivo (POP017+) para WSL2 + Wayland + GitHub SSH
#  Autor: devLaboware  ·  Última revisão: 2025‑06‑29
# ============================================================================

# 0) Aborta se não for shell interativo --------------------------------------
case $- in *i*) ;; *) return ;; esac

# 1) Define verbosidade padrão (0 = silencioso, 1 = verboso)
export BASHRC_VERBOSE=0

# 2) Carrega função de carregamento modular
if [ -f ~/.config/bashrc/ldbash.sh ]; then
  source ~/.config/bashrc/ldbash.sh
fi

# 3) Carrega módulos
load_bashrc_part "history.sh"      "Histórico com data/hora e sem duplicatas"
load_bashrc_part "options.sh"      "Ajustes do Bash"
load_bashrc_part "env.sh"          "Variáveis de ambiente"
load_bashrc_part "functions.sh"    "Funções auxiliares"
load_bashrc_part "git_config.sh"   "Configuração do Git e SSH"
load_bashrc_part "aliases.sh"      "Aliases gerais"
load_bashrc_part "prompt.sh"       "Prompt customizado"
load_bashrc_part "wsl.sh"          "Configuração WSL e Wayland"
load_bashrc_part "dircolors.sh"    "Cores do ls via dircolors"

# 4) Pós-init: vai para o diretório HOME ao iniciar
cd ~
