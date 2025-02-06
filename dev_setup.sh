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
        sudo apt install -y $package
    fi
done

# Install and configure lsd
if ! command -v lsd &> /dev/null; then
    wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb -O /tmp/lsd.deb
    sudo dpkg -i /tmp/lsd.deb
    rm /tmp/lsd.deb
fi

# Configure LSD aliases
if ! grep -q "# LSD aliases" ~/.zshrc; then
    cat >> ~/.zshrc << 'EOL'
# LSD aliases
alias ls='lsd --group-dirs first --icon always'
alias ll='lsd -la --group-dirs first --icon always'
alias lt='lsd --tree --group-dirs first --icon always'
alias l='lsd -l --group-dirs first --icon always'
EOL
fi

# Install Nerd Font
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

# Configure Git
git config --global user.name "sandovaldavid"
git config --global user.email "sandovaldavid2202@gmail.com"
git config --global credential.helper store
git config --global init.defaultBranch main

# Install bat and handle Ubuntu's batcat naming
if ! command -v bat &> /dev/null; then
    echo "Installing bat..."
    sudo apt install -y bat
    
    # Create bat symlink if Ubuntu's batcat is present
    if [ -f /usr/bin/batcat ]; then
        mkdir -p ~/.local/bin
        ln -sf /usr/bin/batcat ~/.local/bin/bat
        
        # Add .local/bin to PATH if not already present
        if ! grep -q "PATH.*/.local/bin" ~/.zshrc; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        fi
    fi
fi

# Configure bat aliases and settings
if ! grep -q "# BAT Configuration" ~/.zshrc; then
    cat >> ~/.zshrc << 'EOL'

# BAT Configuration
alias cat="$(which batcat || which bat) --style=numbers,changes,header"
export BAT_THEME="Dracula"
export BAT_STYLE="numbers,changes,header"
EOL
fi

echo "Development setup completed."
echo "Please:"
echo "1. Configure terminal to use 'JetBrainsMono Nerd Font'"
echo "2. Restart terminal"
echo "3. Run 'source ~/.zshrc'"