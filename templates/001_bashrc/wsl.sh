# Detecta se está rodando no WSL
if grep -qi microsoft /proc/version 2>/dev/null; then
  export IN_WSL=1

  # Configurações para Wayland (WSLg)
  ln -sf /mnt/wslg/runtime-dir/wayland-0* /run/user/$(id -u)/ 2>/dev/null
  export ELECTRON_OZONE_PLATFORM_HINT=wayland
  export OZONE_PLATFORM=wayland
  export WAYLAND_DISPLAY=wayland-0
  export GTK_THEME="Adwaita:dark"
  export DONT_PROMPT_WSL_INSTALL=1

  # Propaga ao ambiente Windows → Linux
  export WSLENV=$WSLENV:ELECTRON_OZONE_PLATFORM_HINT/u

  # Alias para iniciar Firefox no WSL com Wayland
  alias firefox='MOZ_ENABLE_WAYLAND=1 LIBGL_ALWAYS_SOFTWARE=1 MOZ_DISABLE_RDD_SANDBOX=1 MOZ_WEBRENDER=0 nohup /usr/bin/firefox "$@" >/dev/null 2>&1 &'

  # VS Code sempre em Wayland
  alias vscode='code --ozone-platform=wayland'

  # Windsurf GUI   alias ws='windsurf --ozone-platform=wayland'
fi
