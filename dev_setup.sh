#!/bin/bash

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script with sudo"
    exit 1
fi

# Update system packages
echo "Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

# Install base packages if not present
echo "Verificando paquetes base..."
PACKAGES="fzf bat exa tldr unzip wget curl"
for package in $PACKAGES; do
    if ! command -v $package &> /dev/null; then
        echo "Instalando $package..."
        sudo apt install -y $package
    fi
done

# Install and configure lsd
if ! command -v lsd &> /dev/null; then
    echo "Instalando lsd..."
    wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb -O /tmp/lsd.deb
    sudo dpkg -i /tmp/lsd.deb
    rm /tmp/lsd.deb
fi

# Configure aliases for lsd
if ! grep -q "# LSD aliases" ~/.zshrc; then
    echo "Configurando aliases de lsd..."
    cat >> ~/.zshrc << 'EOL'
# LSD aliases
alias ls='lsd --group-dirs first --icon always'
alias ll='lsd -la --group-dirs first --icon always'
alias lt='lsd --tree --group-dirs first --icon always'
alias l='lsd -l --group-dirs first --icon always'
EOL
fi

# Install Nerd Font
echo "Verificando Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"

if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
fi

if ! ls $FONT_DIR/$FONT_NAME*.ttf &> /dev/null; then
    echo "Instalando $FONT_NAME Nerd Font..."
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
    unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR/"
    rm /tmp/JetBrainsMono.zip
    fc-cache -fv
fi

# Configure Git if needed
if [ "$(git config --global user.name)" != "sandovaldavid" ]; then
    echo "Configurando Git..."
    git config --global user.name "sandovaldavid"
    git config --global user.email "sandovaldavid2202@gmail.com"
    git config --global credential.helper store
    git config --global init.defaultBranch main
fi

echo "Configuración completada."
echo "Por favor:"
echo "1. Configure su terminal para usar '$FONT_NAME Nerd Font'"
echo "2. Reinicie su terminal"
echo "3. Ejecute 'source ~/.zshrc'"