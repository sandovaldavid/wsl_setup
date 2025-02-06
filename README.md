# WSL Development Environment Setup 🚀

[![ZSH](https://img.shields.io/badge/Shell-ZSH-blue)](https://www.zsh.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![WSL](https://img.shields.io/badge/Platform-WSL-yellow)](https://docs.microsoft.com/en-us/windows/wsl/)

## Overview 📝

This repository contains scripts to set up a modern development environment in WSL (Windows Subsystem for Linux). It includes configuration for ZSH, development tools, and various productivity enhancements.

## Features ✨

- 🛠️ Modern shell setup with Oh My Zsh
- 🎨 Beautiful terminal with icons and syntax highlighting
- 📂 Enhanced file navigation and listing
- ⚡ Productivity tools and aliases
- 🔍 Fuzzy finding capabilities
- 🐍 Python environment with Miniconda
- 📦 Node.js development environment

## Prerequisites 📋

- WSL installed on Windows
- Ubuntu or Debian-based distribution
- Internet connection for downloading packages

## Installation 💻

1. Clone this repository:
```bash
git clone https://github.com/sandovaldavid/wsl_setup.git
cd wsl-setup
```

2. Make the scripts executable:
```bash
chmod +x zsh_setup.sh dev_setup.sh
```

3. Run the setup scripts in order:
```bash
./zsh_setup.sh
./dev_setup.sh
```

## What's Included 📦

### ZSH Setup (zsh_setup.sh)
- Oh My Zsh installation
- Syntax highlighting
- Auto-suggestions
- Custom aliases
- History configuration

### Development Tools (dev_setup.sh)
- 🎨 Modern CLI tools:
  - `lsd` - Enhanced `ls` command
  - `bat` - Better `cat` command
  - `exa` - Modern replacement for `ls`
  - `fzf` - Fuzzy finder
  - `tldr` - Simplified man pages
- 🔤 JetBrains Mono Nerd Font
- ⚙️ Git configuration
- 📝 Development utilities

## Post-Installation 🎯

After installation:
1. Restart your terminal
2. Configure your terminal to use "JetBrainsMono Nerd Font"
3. Run `source ~/.zshrc`

## Available Commands 🔧

```bash
# List files with icons
ls              # Modern directory listing
ll              # Detailed directory listing
lt              # Tree view of directory

# Navigation
..              # Go up one directory
fzf             # Fuzzy find files

# Development
bat             # Enhanced file viewer
tldr            # Quick command reference
```

## Customization 🎨

You can customize your environment by editing:
- `~/.zshrc` for ZSH configurations
- `~/.gitconfig` for Git settings

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

- [Oh My Zsh](https://ohmyz.sh/)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [WSL Community](https://github.com/microsoft/WSL)

---

<p align="center">
Made with ❤️ for the developer community
@sandovaldavid
</p>
