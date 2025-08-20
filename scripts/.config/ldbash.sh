#!/bin/bash
# ldbash.sh — Carrega módulos do bashrc modular com controle de verbosidade

# Função para carregar um arquivo modular
# Uso: load_bashrc_part "arquivo.sh" "comentário descritivo"
load_bashrc_part() {
  local file="$1"
  local comment="$2"
  local path="$HOME/.config/bashrc/$file"

  if [ -f "$path" ]; then
    [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] carregando: $file - $comment"
    source "$path"
    [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] carregado: $file"
  else
    [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] arquivo não encontrado: $file"
  fi
}
