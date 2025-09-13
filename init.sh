#!/usr/bin/env bash

set -e  # Exit on any error

echo "🚀 Starting Mac setup with guthyerrz's dotfiles..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script is designed for macOS only"
    exit 1
fi

# Install Command Line Tools if not present
if ! xcode-select -p &> /dev/null; then
    echo "📦 Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "⏳ Please complete the Xcode Command Line Tools installation and re-run this script"
    exit 0
fi

# Clone dotfiles repository if not already present
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📥 Cloning dotfiles repository..."
    git clone https://github.com/guthyerrz/dotfiles.git "$DOTFILES_DIR"
else
    echo "📁 Dotfiles directory already exists, pulling latest changes..."
    cd "$DOTFILES_DIR"
    git pull origin main
fi

# Navigate to dotfiles directory
cd "$DOTFILES_DIR"

# Install Nix if not present
if ! command -v nix &> /dev/null; then
    echo "❄️  Installing Nix..."
    curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
    
    # Source Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
fi

echo "🔧 Building and applying Darwin configuration..."

# Navigate to nix-darwin directory for flake
cd "$DOTFILES_DIR/nix-darwin"

# First time setup - creates darwin-rebuild command
echo "🔧 Running nix-darwin system activation..."
echo "🔐 You will be prompted for your password for system-level changes..."

# Ensure Nix is in PATH and run with proper environment
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Run the nix-darwin switch with sudo only for this command
sudo -E nix run nix-darwin -- switch --flake .

echo "✅ Setup complete!"
echo ""
echo "🔄 Please restart your terminal or run: exec zsh"
echo "📝 Don't forget to configure Git:"
echo "   git config --global user.name 'Your Name'"
echo "   git config --global user.email 'your.email@example.com'"
echo ""
echo "🔄 To update in the future, run:"
echo "   cd ~/dotfiles && git pull && cd nix-darwin && darwin-rebuild switch --flake ."
