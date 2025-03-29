# WSL Development Environment Setup 🚀

[![ZSH](https://img.shields.io/badge/Shell-ZSH-blue)](https://www.zsh.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![WSL](https://img.shields.io/badge/Platform-WSL-yellow)](https://docs.microsoft.com/en-us/windows/wsl/)

## Overview 📝

This repository contains scripts to set up a modern development environment in WSL (Windows Subsystem for Linux). It includes configuration for ZSH, development tools, and various productivity enhancements.

## Features ✨

-   🛠️ Modern shell setup with Oh My Zsh
-   🎨 Beautiful terminal with icons and syntax highlighting
-   📂 Enhanced file navigation and listing
-   ⚡ Productivity tools and aliases
-   🔍 Fuzzy finding capabilities
-   🐍 Python environment with Miniconda
-   📦 Node.js development environment

## Prerequisites 📋

-   WSL installed on Windows
-   Ubuntu or Debian-based distribution
-   Internet connection for downloading packages

## Installation 💻

1. Clone this repository:

```bash
git clone https://github.com/sandovaldavid/wsl_setup.git
cd wsl_setup
```

2. Make the scripts executable:

```bash
chmod +x wsl_setup.sh zsh_setup.sh dev_setup.sh
```

3. Choose your installation method:

    A. **Recommended: Full Setup** (All tools and configurations in one command):

    ```bash
    ./wsl_setup.sh
    ```

    B. **Advanced: Step-by-step setup** (For customized installation):

    ```bash
    # First, set up just the ZSH environment
    ./zsh_setup.sh

    # Then, install development tools
    ./dev_setup.sh
    ```

## Available Scripts 📜

### 1. `wsl_setup.sh` - Complete Setup

The main orchestration script that runs both specialized setup scripts in the correct order:

-   Guides you through the entire setup process
-   Handles script execution order
-   Provides clear progress and completion information

### 2. `zsh_setup.sh` - Shell Environment

Sets up your ZSH terminal environment:

-   Installs ZSH shell and Oh My ZSH framework
-   Configures syntax highlighting and autosuggestions
-   Sets up useful aliases and shell history settings
-   Makes ZSH your default shell

### 3. `dev_setup.sh` - Development Tools

Installs and configures developer tools:

-   Modern CLI tools (`lsd`, `bat`, `eza`, `fzf`, `tldr`)
-   JetBrains Mono Nerd Font with development icons
-   Node.js environment with NVM and Bun
-   Python with Miniconda
-   Git configuration and productivity settings

## What Gets Installed 📦

### Shell Enhancements

-   Oh My Zsh - Modern ZSH framework
-   Syntax highlighting - Color coding for commands
-   Auto-suggestions - Command completion based on history

### Modern CLI Tools

-   `lsd` - Enhanced `ls` with icons and colors
-   `bat` - Better `cat` with syntax highlighting
-   `eza` - Modern replacement for `ls`
-   `fzf` - Fuzzy finder for files and history
-   `tldr` - Simplified man pages with examples

### Development Environment

-   JetBrains Mono Nerd Font - Developer font with icons
-   Git configuration - Sensible defaults
-   Node.js with NVM - JavaScript development
-   Bun - Fast JavaScript runtime and package manager
-   Miniconda - Python environment manager

## Post-Installation 🎯

After installation:

1. Restart your terminal
2. Configure your terminal to use "JetBrainsMono Nerd Font"
3. Run `source ~/.zshrc`

## Available Commands 🔧

```bash
# List files with icons
ls              # Modern directory listing
ll              # Detailed directory listing with hidden files
lt              # Tree view of directory
l               # Long listing format

# Navigation
..              # Go up one directory
fzf             # Fuzzy find files

# Development
bat             # Enhanced file viewer
tldr            # Quick command reference
```

## Customization 🎨

You can customize your environment by editing:

-   `~/.zshrc` for ZSH configurations
-   `~/.gitconfig` for Git settings

## Troubleshooting 🔍

If icons are not displaying correctly:

1. Ensure JetBrainsMono Nerd Font is installed
2. Configure your terminal to use the Nerd Font
3. Restart your terminal

## Contributing 🤝

Feel free to submit issues and enhancement requests!

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments 🙏

-   [Oh My Zsh](https://ohmyz.sh/)
-   [Nerd Fonts](https://www.nerdfonts.com/)
-   [WSL Community](https://github.com/microsoft/WSL)

---

<p align="center">
  <span style="display: inline-block; text-align: center;">
    <div style="margin-bottom: 10px; text-align:center;">
      Made by 
      <a href="https://github.com/sandovaldavid">@sandovaldavid</a>
    </div>
    <img src="https://res.cloudinary.com/dfs757coe/image/upload/c_scale,w_50/v1743282980/Projects/Logo/Byte-logo_jijtxn.jpg" alt="Byte Logo" style="display: block; margin: 0 auto;">
  </span>
</p>
