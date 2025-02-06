#!/bin/bash

# Actualizar paquetes
sudo apt update && sudo apt upgrade -y

# Instalar dependencias necesarias
sudo apt install -y zsh curl git fzf bat exa tldr unzip

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

# Instalar lsd
if ! command -v lsd &> /dev/null; then
    wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb -O /tmp/lsd.deb
    sudo dpkg -i /tmp/lsd.deb
    rm /tmp/lsd.deb
fi

# Configurar alias para ls
if ! grep -q "alias ls='lsd'" ~/.zshrc; then
    echo "alias ls='lsd'" >> ~/.zshrc
fi

# Configurar autocompletado con fzf
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# Configurar historial solo para comandos exitosos
echo 'export HISTIGNORE="&:[ ]*:exit:clear"' >> ~/.zshrc
echo 'export HISTCONTROL=ignoredups' >> ~/.zshrc

# Configurar Git con tu cuenta de GitHub
git config --global user.name "sandovaldavid"
git config --global user.email "sandovaldavid2202@gmail.com"
git config --global credential.helper store

# Configurar Git para que la rama inicial sea 'main'
git config --global init.defaultBranch main

# Instalar la última versión estable de Conda
if [ ! -d "$HOME/miniconda3" ]; then
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
    bash /tmp/miniconda.sh -b -p $HOME/miniconda3
    rm /tmp/miniconda.sh
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc
    echo 'conda config --set auto_activate_base false' >> ~/.zshrc
fi

# Instalar Node.js y administradores de versiones
if ! command -v nvm &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc
fi
source ~/.zshrc
nvm install --lts
nvm use --lts

# Instalar npm y Bun
npm install -g npm
# Update tldr database
tldr --update || true
curl -fsSL https://bun.sh/install | bash

# Configurar navegación rápida en la terminal
echo 'setopt autocd' >> ~/.zshrc
echo 'alias ..="cd .."' >> ~/.zshrc
echo 'alias cat="bat"' >> ~/.zshrc
echo 'alias ls="exa"' >> ~/.zshrc

# Aplicar cambios
echo "Personalización completada. Reinicia la terminal o ejecuta 'exec zsh' para aplicar los cambios."
