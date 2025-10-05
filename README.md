# MacNewStarter

A personal, modular setup script for quickly configuring a new Mac (Apple Silicon or Intel) with all your preferred tools, apps, dotfiles, and configs.

## Features

- Installs CLI tools, Homebrew, GUI apps, VSCode extensions, and more
- Sets up your personal dotfiles and config files via symlinks, allowing for git tracking
- Menu-driven, modular, and safe (with confirmations)
- Designed for Apple Silicon and Intel Macs

## Prerequisites

- macOS
- git (to clone this repo)
- Internet connection (for Homebrew, app, and extension downloads)

## Usage

1. **Clone or copy this repo to your new Mac:**

   ```sh
   git clone https://github.com/joehall02/MacNewStarter.git
   cd MacNewStarter
   ```

2. **Run the main installer:**
   ```sh
   chmod +x run.sh
   bash run.sh
   ```
   Follow the menu prompts to install everything or individual components.

## What Gets Installed

- **Xcode Command Line Tools**
- **Homebrew** (and all packages in `lists/cli-tools.txt` and `lists/packages.txt`)
- **GUI Apps** (from `lists/gui-apps.txt`)
- **VSCode Extensions** (from `lists/vscode-extensions.txt`)
- **Dotfiles** (from `dotfiles/`, symlinked to your home directory)
- **Configs** (from `configs/`, symlinked to `~/.config/`)
- **Zap Zsh plugin manager**

## Customization

- **Add or edit dotfiles:** Place your dotfiles in the `dotfiles/` directory.
- **Add or edit configs:** Place your app configs in the `configs/` directory (subfolders supported).
- **Edit package/app lists:** Update the files in `lists/` to match your preferences.

## Notes

- All actions require confirmation by default for safety.
- Existing dotfiles are backed up before being replaced.
- Designed for personal use—review and adjust for your own needs!
- Review the project yourself before running on your own system!
