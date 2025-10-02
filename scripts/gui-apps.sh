#!/bin/bash

# Install GUI applications using Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Read the list of GUI applications from the config file
while IFS= read -r app; do
    if ! brew list --cask | grep -q "^$app\$"; then
        echo "Installing $app..."
        brew install --cask "$app"
    else
        echo "$app is already installed."
    fi
done < ../config/gui-apps.txt

echo "GUI applications installation completed."