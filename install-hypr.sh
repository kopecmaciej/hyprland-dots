#!/bin/bash

# Make script executable
chmod +x ~/.config/hypr/scripts/install-hypr.sh

# Install necessary packages
sudo pacman -S --needed \
    hyprland \
    waybar \
    rofi-wayland \
    wezterm \
    dunst \
    pipewire \ 
    wireplumber \
    hyprpaper \
    polkit-kde-agent \
    xdg-desktop-portal-hyprland \
    dolphin \
    brightnessctl \
    playerctl \
    pamixer

# Create necessary directories
mkdir -p ~/.config/{hypr,waybar,rofi,wezterm}

# Copy config files
cp /etc/xdg/waybar/config ~/.config/waybar/
cp /etc/xdg/waybar/style.css ~/.config/waybar/

## additionals 

sudo pacman -S \
  lazygit
