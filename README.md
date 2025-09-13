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

- `nix-darwin/flake.nix` - System packages, Homebrew apps, macOS settings with multiple host configurations
- `nix-darwin/home.nix` - User environment and dotfile management
- `ruby/` - Ruby gems managed via Nix bundlerEnv
- Other directories - Your actual configuration files

## 🔄 Making Changes

After editing configurations:
```bash
cd ~/dotfiles/nix-darwin
darwin-rebuild switch --flake .#$(hostname | sed 's/\.local$//')
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

The flake defines multiple host configurations within `flake.nix`. During setup, it automatically detects your hostname and username, then selects the appropriate configuration. If your specific hostname isn't defined, it falls back to a default configuration that uses environment variables. This approach keeps everything in Git while remaining portable across different machines.

### Adding New Hosts

To add a new machine, simply add it to the `darwinConfigurations` in `flake.nix`:

```nix
"your-hostname" = mkDarwinConfiguration {
  hostname = "your-hostname";
  username = "your-username";
};
```
