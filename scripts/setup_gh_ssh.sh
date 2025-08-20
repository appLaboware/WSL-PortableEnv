#!/bin/bash

# 🛠️ **Script de Configuração de Acesso ao GitHub via SSH e `gh`** 🚀

echo "🔍 Verificando requisitos..."

# Verificar e instalar pacotes necessários
for package in git openssh-client gh; do
    if ! command -v $package &>/dev/null; then
        echo "⚠️ Pacote $package não encontrado. Instalando..."
        sudo apt update && sudo apt install -y $package
    else
        echo "✅ $package já está instalado."
    fi
done

# Coletar informações do usuário
echo -e "\n📋 **Configuração do Git**"
read -p "Digite seu nome para o Git: " GIT_USER
read -p "Digite seu email para o Git: " GIT_EMAIL

# Configurar Git
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
echo "✅ Git configurado com sucesso!"

# Configurar systemd para WSL2 (Opcional)
if grep -q Microsoft /proc/version; then
    echo "⚠️ WSL detectado. Configurando Systemd..."
    echo -e "[boot]\n\tsystemd=true" | sudo tee /etc/wsl.conf > /dev/null
    wsl --shutdown
    echo "✅ Systemd configurado! Reinicie o WSL."
fi

# Verificar se chave SSH já existe
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
    echo "✅ Chave SSH já existe."
else
    echo "🔑 Gerando chave SSH..."
    read -p "Digite seu email para a chave SSH: " SSH_EMAIL
    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$SSH_KEY" -N ""
    echo "✅ Chave SSH gerada!"
fi

# Exibir chave pública para cópia
echo -e "\n📋 **Adicione esta chave ao GitHub (Configurações > SSH Keys)**:"
cat "$SSH_KEY.pub"

# Adicionar chave ao agente SSH
eval $(ssh-agent)
ssh-add "$SSH_KEY"
echo "✅ Chave SSH adicionada ao agente!"

# Criar configuração SSH para o GitHub
echo "⚙️ Configurando SSH para o GitHub..."
SSH_CONFIG="$HOME/.ssh/config"
if ! grep -q "github.com" "$SSH_CONFIG" 2>/dev/null; then
    echo -e "Host github.com\n\tUser git\n\tIdentityFile $SSH_KEY\n\tAddKeysToAgent yes\n\tStrictHostKeyChecking no" >> "$SSH_CONFIG"
    echo "✅ Configuração SSH adicionada!"
else
    echo "✅ Configuração SSH já existente."
fi

# Autenticar no GitHub CLI
echo "🔐 Autenticando no GitHub CLI..."
gh auth login --git-protocol ssh

# Forçar Git a usar SSH para GitHub
echo "🔄 Configurando Git para sempre usar SSH..."
git config --global url."git@github.com:".insteadOf "https://github.com/"
echo "✅ Git configurado para SSH!"

# Testar autenticação SSH com o GitHub
echo "🔍 Testando conexão SSH com o GitHub..."
ssh -T git@github.com

# Testar autenticação no GitHub CLI
echo "🔍 Testando autenticação no GitHub CLI..."
gh auth status

# Validar que o setup permite adicionar submódulos
echo "🔎 Validando permissão para adicionar submódulos..."
TEST_REPO="git@github.com:usuario/teste-submodulo.git"
git ls-remote "$TEST_REPO" &>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Permissão para adicionar submódulos confirmada!"
else
    echo "❌ ERRO: Não foi possível verificar o acesso ao repositório para submódulos."
fi

echo "🎉 **Configuração concluída com sucesso!** 🚀"
