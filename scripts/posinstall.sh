#!/bin/bash

# Funções para saída colorida
print_info() {
    echo -e "\033[1;34mℹ️  $1\033[0m"
}

print_success() {
    echo -e "\033[1;32m✅  $1\033[0m"
}

print_warning() {
    echo -e "\033[1;33m⚠️  $1\033[0m"
}

print_error() {
    echo -e "\033[1;31m❌  $1\033[0m"
}

# Início da configuração
print_info "Iniciando configuração para isolamento no WSL..."

# Configurar o diretório inicial do WSL
print_info "Configurando o WSL para iniciar no diretório do usuário..."
BASHRC_PATH="$HOME/.bashrc"
if ! grep -q "cd ~" "$BASHRC_PATH"; then
    echo "cd ~" >> "$BASHRC_PATH"
    print_success "Configuração para iniciar no diretório do usuário adicionada ao .bashrc."
else
    print_warning "Configuração para iniciar no diretório do usuário já existe."
fi

# Configurar o nome do host
NEW_HOSTNAME="wsl-env"
print_info "Configurando o hostname para $NEW_HOSTNAME..."
if echo "$NEW_HOSTNAME" | sudo tee /etc/hostname > /dev/null; then
    print_success "Hostname configurado com sucesso em /etc/hostname."
else
    print_error "Falha ao configurar o hostname em /etc/hostname."
fi

# Atualizar o arquivo /etc/hosts
if sudo sed -i "s/127.0.0.1.*/127.0.0.1 localhost $NEW_HOSTNAME/" /etc/hosts; then
    print_success "Arquivo /etc/hosts atualizado com sucesso."
else
    print_error "Falha ao atualizar o arquivo /etc/hosts."
fi

# Adicionar configuração ao wsl.conf
WSL_CONFIG="/etc/wsl.conf"
print_info "Atualizando o arquivo $WSL_CONFIG..."
if sudo tee "$WSL_CONFIG" > /dev/null <<EOF
[boot]
systemd=true

[automount]
enabled = true
root = /mnt/

[user]
default = $(whoami)

[network]
hostname = $NEW_HOSTNAME
generateResolvConf = false
EOF
then
    print_success "Configuração do arquivo $WSL_CONFIG concluída."
else
    print_error "Falha ao configurar o arquivo $WSL_CONFIG."
fi

# Configurar DNS no resolv.conf
print_info "Configurando DNS para usar o Google (8.8.8.8)..."
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
print_success "DNS configurado para 8.8.8.8."

# Garantir que o DNS seja atualizado ao iniciar o WSL
print_info "Adicionando reescrita do resolv.conf ao .bashrc..."
if ! grep -q "nameserver 8.8.8.8" "$BASHRC_PATH"; then
    echo "echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf > /dev/null" >> "$BASHRC_PATH"
    print_success "Reescrita automática do resolv.conf adicionada ao .bashrc."
else
    print_warning "Reescrita do resolv.conf já existe no .bashrc."
fi

# Instruções para reiniciar
print_info "Configuração de isolamento no WSL concluída!"
print_warning "Execute 'wsl.exe --shutdown' no terminal do Windows para aplicar as alterações."
