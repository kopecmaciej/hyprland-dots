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
    sddm \
    swaync \
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
  wlogout \
  lazygit \
  rsync \
  syncthing \ 
  starship \
  yarn \
  ripgrep \
  pyenv 
 
yay -S \
   ttf-meslo-nerd-font-powerlevel10k

### Commands

sudo systemctl enable sddm

### SDDM themes
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf


