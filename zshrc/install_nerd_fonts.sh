#!/bin/bash

# Check for necessary dependencies
dependencies=(git curl)

for dep in "${dependencies[@]}"; do
    if ! command -v $dep &> /dev/null; then
        echo "$dep is not installed. Installing..."
        sudo apt install $dep -y
    else
        echo "$dep is already installed."
    fi
done

# Clone the Nerd Fonts repository
echo "Cloning Nerd Fonts repository..."
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git

# Change directory to nerd-fonts
cd nerd-fonts || exit

# Specify the font you want to install
font_name="FiraCode"  # Change this to your desired font (e.g., Hack, Ubuntu Mono)

# Install the specified font
echo "Installing $font_name Nerd Font..."
./install.sh "$font_name"

# Update the font cache
echo "Updating font cache..."
fc-cache -f -v

echo "$font_name Nerd Font installation completed!"
