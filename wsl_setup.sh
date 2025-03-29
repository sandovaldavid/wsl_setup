#!/bin/bash
#
# WSL Complete Setup Script
# ------------------------
# This script orchestrates the complete WSL development environment setup
# by executing the specialized setup scripts in the correct order.
#
# Author: David Sandoval
# Version: 1.0
# License: MIT

# Exit on error
set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this script with sudo"
    exit 1
fi

# Define script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Display welcome message
echo "════════════════════════════════════════════"
echo "🚀 WSL Development Environment Setup"
echo "════════════════════════════════════════════"
echo "This script will set up your complete WSL development environment"
echo "by running the following scripts in sequence:"
echo ""
echo "  1. ZSH Setup (zsh_setup.sh)"
echo "  2. Development Tools Setup (dev_setup.sh)"
echo ""
echo "The setup will take several minutes and may require your input."

# Confirm before proceeding
read -p "Do you want to continue? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup canceled."
    exit 0
fi

# Make sure scripts are executable
echo "📋 Making scripts executable..."
chmod +x "$SCRIPT_DIR/zsh_setup.sh" "$SCRIPT_DIR/dev_setup.sh"

# Execute ZSH Setup
echo ""
echo "════════════════════════════════════════════"
echo "Step 1: Setting up ZSH environment"
echo "════════════════════════════════════════════"
"$SCRIPT_DIR/zsh_setup.sh"

# Execute Development Tools Setup
echo ""
echo "════════════════════════════════════════════"
echo "Step 2: Setting up development tools"
echo "════════════════════════════════════════════"
"$SCRIPT_DIR/dev_setup.sh"

# Setup complete
echo ""
echo "════════════════════════════════════════════"
echo "✅ WSL Development Environment Setup Complete!"
echo "════════════════════════════════════════════"
echo ""
echo "🎉 Your WSL development environment has been successfully configured!"
echo ""
echo "What's next:"
echo "  1. Restart your terminal"
echo "  2. Configure your terminal to use 'JetBrainsMono Nerd Font'"
echo "  3. Enjoy your enhanced development environment!"
echo ""
echo "For more information and available commands, see the README.md"
