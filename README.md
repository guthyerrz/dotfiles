# Nix-Darwin + Home Manager Dotfiles

A declarative macOS configuration using Nix-Darwin and Home Manager.

## 🚀 Quick Setup

### One-liner (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/guthyerrz/dotfiles/main/init.sh | bash
```

### Manual Setup
```bash
# Clone and run the setup script
git clone https://github.com/guthyerrz/dotfiles.git ~/dotfiles
cd ~/dotfiles
./init.sh
```

## 📁 Structure

- `nix-darwin/flake.nix` - System packages, Homebrew apps, macOS settings
- `nix-darwin/home.nix` - User environment and dotfile management
- Other directories - Your actual configuration files

## 🔄 Making Changes

After editing configurations:
```bash
cd ~/dotfiles/nix-darwin
darwin-rebuild switch --flake .
```

## 🎯 Features

- ✅ Declarative system configuration
- ✅ Reproducible across machines  
- ✅ Version controlled dotfiles
- ✅ Rollback capability
- ✅ Automatic Homebrew management
