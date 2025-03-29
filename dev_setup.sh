#!/bin/bash

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script with sudo"
    exit 1
fi

# Update system and install base packages
echo "Installing development tools..."
sudo apt update && sudo apt upgrade -y
PACKAGES="fzf bat exa tldr unzip wget curl"
for package in $PACKAGES; do
    if ! command -v $package &> /dev/null; then
        echo "Installing $package..."
        sudo apt install -y $package || echo "Warning: Could not install $package from repositories"
    fi
done

# System Tools Installation
# ------------------------

# Install and configure lsd
if ! command -v lsd &> /dev/null; then
    echo "Installing lsd..."
    wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb -O /tmp/lsd.deb
    sudo dpkg -i /tmp/lsd.deb
    rm /tmp/lsd.deb
fi

# Install eza (modern replacement for exa)
if ! command -v eza &> /dev/null; then
    echo "Installing eza..."
    EZA_VERSION="0.16.0"
    wget https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz -O /tmp/eza.tar.gz
    mkdir -p ~/.local/bin
    tar -xf /tmp/eza.tar.gz -C /tmp/
    mv /tmp/eza ~/.local/bin/
    rm /tmp/eza.tar.gz
    # Make sure ~/.local/bin is in PATH
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install and configure bat/batcat
if ! command -v batcat &> /dev/null; then
    echo "Installing bat..."
    sudo apt install -y bat
fi

# Font Installation
# ----------------
echo "Installing JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"

mkdir -p "$FONT_DIR"
if ! ls $FONT_DIR/$FONT_NAME*.ttf &> /dev/null; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
    unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR/"
    rm /tmp/JetBrainsMono.zip
    fc-cache -fv
fi

# Development Tools Setup
# ----------------------

# Configure Git
git config --global user.name "sandovaldavid"
git config --global user.email "sandovaldavid2201@gmail.com"
git config --global credential.helper store
git config --global init.defaultBranch main

# Node.js Setup
# ------------

# Install NVM and Node.js
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM and Node.js..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts

    # Install global npm packages
    npm install -g npm
fi

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Add bun to PATH
export PATH="$HOME/.bun/bin:$PATH"

# Python Setup
# -----------

# Conda installation
if [ ! -d "$HOME/miniconda3" ]; then
    echo "Installing Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
    bash /tmp/miniconda.sh -b -p $HOME/miniconda3
    rm /tmp/miniconda.sh
fi

# Shell Configuration
# -----------------

# Configure shell aliases and paths
if ! grep -q "# Environment Configuration" ~/.zshrc; then
    cat >> ~/.zshrc << 'EOL'

# Environment Configuration
# -----------------------

# PATH configurations
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"

# Conda env name:
conda config --set env_prompt '({name})'

# LSD aliases
alias ls='lsd --group-dirs first --icon always'
alias ll='lsd -la --group-dirs first --icon always'
alias lt='lsd --tree --group-dirs first --icon always'
alias l='lsd -l --group-dirs first --icon always'

# BAT aliases
alias cat='batcat'

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Conda initialization
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda config --set auto_activate_base false
EOL
fi

# Update tldr database
tldr --update || true

echo "Development setup completed."
echo "Please:"
echo "1. Configure terminal to use 'JetBrainsMono Nerd Font'"
echo "2. Close and reopen your terminal"
echo "3. Run: source ~/.zshrc"
