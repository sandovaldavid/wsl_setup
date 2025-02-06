#!/bin/bash

# Instalar dependencias necesarias para ZSH
sudo apt install -y zsh curl git

# Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Instalar plugins de Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || echo "Failed to install zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || echo "Failed to install zsh-syntax-highlighting"
fi

# Configure Oh My Zsh plugins
if [ -f ~/.zshrc ]; then
    if ! grep -q "plugins=(.*zsh-autosuggestions.*zsh-syntax-highlighting.*)" ~/.zshrc; then
        sed -i 's/plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /' ~/.zshrc
    fi
fi

# Configurar navegación rápida en la terminal
echo 'setopt autocd' >> ~/.zshrc
echo 'alias ..="cd .."' >> ~/.zshrc

# Configurar historial solo para comandos exitosos
echo 'export HISTIGNORE="&:[ ]*:exit:clear"' >> ~/.zshrc
echo 'export HISTCONTROL=ignoredups' >> ~/.zshrc

echo "Configuración de ZSH completada. Ejecuta 'exec zsh' para aplicar los cambios."