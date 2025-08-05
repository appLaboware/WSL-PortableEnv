#!/bin/bash

# --------------------------------------------
# 📌 Script de Configuração Pós-Instalação do VSCode no WSL
# --------------------------------------------
# 🔹 Objetivo:
# - Garantir compatibilidade com fontes Unicode e Nerd Fonts
# - Melhorar suporte gráfico no WSL, incluindo Wayland
# - Evitar redundâncias com configurações já feitas
# --------------------------------------------
# 🔹 Execução:
# - Rodar este script **após a instalação do VSCode**
# - Após este, rodar o script de teclado separado, se necessário
# --------------------------------------------

echo "🔧 Iniciando configuração de fontes e suporte gráfico no WSL..."

# --------------------------------------------
# 🖋️ Instalação de Fontes Recomendadas
# --------------------------------------------
echo "🖋️ Instalando fontes essenciais..."
sudo apt update
sudo apt install -y zip unzip fonts-firacode fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-ubuntu

echo "📥 Baixando e instalando Nerd Fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts/
rm FiraCode.zip
fc-cache -fv

# --------------------------------------------
# 🖥️ Configuração Gráfica e Suporte ao Wayland
# --------------------------------------------
echo "🖥️ Instalando suporte gráfico Wayland..."
sudo apt install -y weston wayland-utils

echo "🖥️ Testando Wayland..."
WAYLAND_DISPLAY=wayland-0 wayland-info

# --------------------------------------------
# ✅ Teste Final
# --------------------------------------------
echo "✅ Testando exibição de caracteres especiais..."
echo "📌 ✔ 🔥 🚀"

echo "✅ Configuração concluída! Reinicie o terminal ou rode 'source ~/.bashrc' para aplicar as mudanças."
