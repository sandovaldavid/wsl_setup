#!/bin/bash
#
# ZSH Setup Script for WSL Development Environment
# -----------------------------------------------
# This script installs and configures ZSH with Oh My ZSH and useful plugins
# to create a modern, productive shell environment.
#
# Author: David Sandoval
# Version: 1.0
# License: MIT
#
# Features:
# - Installs ZSH shell and dependencies
# - Configures Oh My ZSH framework
# - Adds syntax highlighting and autosuggestions
# - Sets up basic productivity aliases
# - Configures shell history

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script with sudo"
    exit 1
fi

#--------------------------
# Backup existing configurations
#--------------------------
echo "📦 Backing up existing configurations..."
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup
    echo "  • Backed up existing .zshrc"
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.backup"
    echo "  • Backed up existing Oh My ZSH installation"
fi

#--------------------------
# Install ZSH and dependencies
#--------------------------
echo "🔄 Installing ZSH and dependencies..."
sudo apt install -y zsh curl git

# Create empty zshrc
echo "# Default zshrc" > ~/.zshrc

#--------------------------
# Install Oh My ZSH
#--------------------------
echo "🚀 Installing Oh My ZSH..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#--------------------------
# Install ZSH plugins
#--------------------------
echo "🔌 Installing ZSH plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install autosuggestions plugin (provides suggestions based on command history)
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "  • Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install syntax highlighting plugin (provides fish-like syntax highlighting)
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "  • Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

#--------------------------
# Configure ZSH
#--------------------------
echo "⚙️ Configuring ZSH..."

# Enable plugins in .zshrc
echo "  • Enabling plugins in .zshrc"
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Add useful configurations
echo "  • Adding useful shell configurations"
echo 'setopt autocd' >> ~/.zshrc                           # Change directory without cd command
echo 'alias ..="cd .."' >> ~/.zshrc                        # Quick navigate up one directory
echo 'export HISTIGNORE="&:[ ]*:exit:clear"' >> ~/.zshrc   # Don't save duplicates in history
echo 'export HISTCONTROL=ignoredups' >> ~/.zshrc           # Ignore duplicates in history

#--------------------------
# Set ZSH as default shell
#--------------------------
echo "🔄 Setting ZSH as default shell..."
chsh -s $(which zsh)

echo "✅ ZSH setup completed. Please restart your terminal."