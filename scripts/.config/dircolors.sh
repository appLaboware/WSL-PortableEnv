# Aplica configuração de cores com dircolors
# Tenta arquivo customizado; se falhar, aplica padrão do sistema

if command -v dircolors >/dev/null; then
  if [ -f "$HOME/.config/bashrc/dircolors" ]; then
    if eval "$(dircolors -b "$HOME/.config/bashrc/dircolors" 2>/dev/null)"; then
      [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] dircolors custom aplicado"
    else
      [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] dircolors custom falhou, aplicando padrão"
      if eval "$(dircolors -b)"; then
        [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] dircolors padrão aplicado"
      else
        echo "[bashrc] falha ao aplicar dircolors padrão" >&2
      fi
    fi
  else
    if eval "$(dircolors -b)"; then
      [ "$BASHRC_VERBOSE" = "1" ] && echo "[bashrc] dircolors padrão aplicado"
    else
      echo "[bashrc] falha ao aplicar dircolors padrão" >&2
    fi
  fi
else
  echo "[bashrc] dircolors não disponível no sistema" >&2
fi
