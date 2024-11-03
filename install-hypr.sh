#!/bin/bash

# Make script executable
chmod +x ~/.config/hypr/scripts/install-hypr.sh

# Install necessary packages
sudo pacman -S --needed \
    # base
    hyprland \
    waybar \
    rofi-wayland \
    wezterm \
    dolphin \
    xdg-desktop-portal-hyprland \
    # audio
    pipewire \ 
    pipewire-pulse \
    pipewire-audio \
    wireplumber \
    pavucontrol \
    # fonts 
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    noto-fonts-emoji \
    # utils 
    wl-clipboard
    # dunst \
    # hyprpaper \
    # polkit-kde-agent \
    # brightnessctl \
    # playerctl \
    # pamixer

# Create necessary directories
mkdir -p ~/.config/{waybar,rofi,wezterm}

# Copy config files
cp ./waybar/config ~/.config/waybar/
cp ./waybar/style.css ~/.config/waybar/
cp ./rofi/config.rasi ~/.config/rofi/
cp ./wezterm/wezterm.lua ~/.config/wezterm/

## additionals 

sudo pacman -S \
  lazygit \
  rsync \
  syncthing

