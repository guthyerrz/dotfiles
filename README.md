# Nix-Darwin + Home Manager Dotfiles

A declarative macOS configuration using Nix-Darwin and Home Manager.

## 🚀 Quick Setup

### One-liner (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/guthyerrz/dotfiles/main/init.sh | bash
```
*Note: The script will prompt for your password to run system-level changes with sudo.*

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
- `nix-darwin/config.nix.template` - Template for host-specific configuration
- `nix-darwin/config.nix` - Generated host-specific config (not tracked in git)
- `ruby/` - Ruby gems managed via Nix bundlerEnv
- Other directories - Your actual configuration files

## 🔄 Making Changes

After editing configurations:
```bash
cd ~/dotfiles/nix-darwin
darwin-rebuild switch --flake .
```

## 🎯 Features

- ✅ **Host-agnostic setup** - Works on any Mac with any username
- ✅ **Declarative system configuration** - Everything defined in code
- ✅ **Reproducible across machines** - Same setup everywhere
- ✅ **Version controlled dotfiles** - All configs tracked in git
- ✅ **Rollback capability** - Can revert to previous configurations
- ✅ **Automatic Homebrew management** - GUI apps installed automatically
- ✅ **Ruby gems via Nix** - Fastlane, CocoaPods managed declaratively

## 🔧 How It Works

The setup automatically detects your hostname and username during first run, generating a `config.nix` file that's used by both nix-darwin and home-manager. This file is not tracked in git, making the dotfiles portable across different machines.
