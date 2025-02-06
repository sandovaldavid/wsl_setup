#!/bin/bash

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script with sudo"
    exit 1
fi

# Create empty zshrc to skip new user setup
if [ ! -f ~/.zshrc ]; then
    touch ~/.zshrc
fi

# Limpiar configuraciones previas
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.backup"
fi

# Instalar dependencias necesarias para ZSH
if ! sudo apt install -y zsh curl git; then
    echo "Failed to install dependencies"
    exit 1
fi

# Create default .zshrc to prevent new user setup
echo "# Default zshrc to prevent new user setup" > ~/.zshrc

# Instalar Oh My Zsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Instalar plugins de Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Configure Oh My Zsh plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Configurar navegación rápida en la terminal
echo 'setopt autocd' >> ~/.zshrc
echo 'alias ..="cd .."' >> ~/.zshrc

# Configurar historial
echo 'export HISTIGNORE="&:[ ]*:exit:clear"' >> ~/.zshrc
echo 'export HISTCONTROL=ignoredups' >> ~/.zshrc

# Cambiar shell por defecto a zsh
chsh -s $(which zsh)

echo "Configuración de ZSH completada. Por favor, reinicia tu terminal."