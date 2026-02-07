# MacNewStarter

A personal, modular setup script for quickly configuring a new Mac (Apple Silicon or Intel) with all your preferred tools, apps, dotfiles, configs, vscode settings and docker files.

## Features

- Installs CLI tools, Homebrew, GUI apps, VSCode extensions, and more.
- Sets up your personal dotfiles, config files, docker files and vscode settings via symlinks, allowing for git tracking.
- Menu-driven, modular, and safe (with confirmations).
- Designed primarily for Apple Silicon but can be used on Intel with some configuration.

## Prerequisites

- macOS
- git (to clone this repo)
- Internet connection (for Homebrew, app, and extension downloads)

## Usage

1. **Clone or copy this repo to your machine:**

   ```sh
   git clone https://github.com/joehall02/MacNewStarter.git
   cd MacNewStarter
   ```

2. **Run the main installer:**
   ```sh
   bash run.sh
   ```
   Follow the menu prompts to install everything or run individual scripts.

## What Gets Installed

- **Xcode Command Line Tools**
- **Homebrew** (and all packages in `lists/cli-tools.txt` and `lists/packages.txt`)
- **GUI Apps** (from `lists/gui-apps.txt`)
- **VSCode Extensions** (from `lists/vscode-extensions.txt`)
- **Dotfiles** (from `dotfiles/`, symlinked to your home directory)
- **Configs** (from `configs/`, symlinked to `~/.config/`)
- **Docker Files** (from `docker/`, symlinked to `~/Docker/`)
- **VSCode Settings** (from `vscode/`, symlinked to `~/Library/Application Support/Code/User/`)
- **Zap Zsh plugin manager**

## Customisation

- **Add or edit dotfiles:** Place your dotfiles in the `dotfiles/` directory.
- **Add or edit configs:** Place your app configs in the `configs/` directory (subfolders supported).
- **Add or edit docker files:** Place your docker files/folders in the `docker/` directory (subfolders supported).
- **Add or edit vscode settings:** Place your vscode settings in the `vscode/` directory.
- **Edit package/app lists:** Update the files in `lists/` to match your preferences.

## Notes

- All actions require confirmation by default for safety.
- Existing dotfiles, configs, docker files and vscode settings are backed up before being replaced.
- Designed for personal use, review and adjust for your own needs!
- Review the project yourself before running on your own system!
- Hardcoded Homebrew bash shebangs in some scripts, will need to be manually adjusted for Intel Macs
