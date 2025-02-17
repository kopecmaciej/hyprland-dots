#!/bin/bash

set -e  # Exit script on error

# Colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Check for yay and install if missing
if ! command -v yay &>/dev/null; then
    echo -e "${YELLOW}yay not found. Installing yay...${RESET}"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

# Function to check for NVIDIA GPU
check_nvidia() {
    lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia
}

# Function to check if NVIDIA drivers are installed
check_nvidia_installed() {
    pacman -Q nvidia-dkms &>/dev/null
}

# Function to prompt yes/no questions, unless --minimal is set
ask_yes_no() {
    if [[ $AUTO_INSTALL == true ]]; then
        return 0
    fi
    while true; do
        read -p "$1 (y/n): " response
        case $response in
            [Yy]*) return 0;;
            [Nn]*) return 1;;
            *) echo "Please answer y or n.";;
        esac
    done
}

# Check for --minimal flag
AUTO_INSTALL=false
if [[ $1 == "--minimal" ]]; then
    AUTO_INSTALL=true
fi

echo -e "${YELLOW}Checking for NVIDIA graphics card...${RESET}"
if check_nvidia; then
    echo -e "${GREEN}✓ NVIDIA GPU detected!${RESET}"
    if check_nvidia_installed; then
        echo -e "${GREEN}✓ NVIDIA drivers are already installed. Skipping installation.${RESET}"
    else
        if ask_yes_no "Would you like to install NVIDIA drivers?"; then
            echo -e "${YELLOW}Installing NVIDIA drivers and dependencies...${RESET}"
            yay -S --needed linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
            
            echo -e "${YELLOW}Configuring NVIDIA modules...${RESET}"
            sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
            sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
            echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
            
            echo -e "${YELLOW}Verifying NVIDIA configuration...${RESET}"
            if grep -q "options nvidia-drm modeset=1" /etc/modprobe.d/nvidia.conf; then
                echo -e "${GREEN}✓ NVIDIA configuration verified successfully${RESET}"
            else
                echo -e "${RED}⚠️ NVIDIA configuration verification failed${RESET}"
            fi
            
            echo -e "${GREEN}NVIDIA setup complete.${RESET}"
            if ask_yes_no "Would you like to reboot now to complete NVIDIA setup?"; then
                sudo reboot
            else
                echo -e "${YELLOW}Please remember to reboot your system later to complete the NVIDIA setup.${RESET}"
            fi
        fi
    fi
fi

echo -e "${YELLOW}Installing essential packages...${RESET}"
packages=(
    wget hyprland waybar rofi-wayland wezterm dolphin xdg-desktop-portal-hyprland
    sddm swaync swww pipewire pipewire-pulse pipewire-audio wireplumber
    pavucontrol unzip zip ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji wl-clipboard
    docker-buildx
)
sudo pacman -S --needed "${packages[@]}"

yay_packages=(hyprshot wlogout helm npm yarn)
yay -S --needed "${yay_packages[@]}"

## RUST
curl https://sh.rustup.rs -sSf | sh

# Ask about additional packages
echo -e "\n${YELLOW}Additional packages available for installation:${RESET}"

echo "1. Development tools (lazygit, yarn, ripgrep)"
if ask_yes_no "Would you like to install development tools?"; then
    sudo pacman -S --needed lazygit yarn ripgrep
fi

echo "2. Sync tools (rsync, syncthing)"
if ask_yes_no "Would you like to install sync tools?"; then
    sudo pacman -S --needed rsync syncthing
fi

echo "3. Shell enhancements (starship, yazi)"
if ask_yes_no "Would you like to install shell enhancements?"; then
    yay -S --needed starship yazi
fi

echo "4. Additional fonts (ttf-meslo-nerd-font-powerlevel10k)"
if ask_yes_no "Would you like to install additional fonts?"; then
    yay -S --needed ttf-meslo-nerd-font-powerlevel10k
fi

# Create necessary directories
mkdir -p ~/.config/{waybar,rofi,wezterm}

# Copy config files
cp -r ./waybar/config ~/.config/waybar/
cp -r ./waybar/style.css ~/.config/waybar/
cp -r ./rofi/config.rasi ~/.config/rofi/
cp -r ./wezterm/wezterm.lua ~/.config/wezterm/

# Enable SDDM
sudo systemctl enable sddm

# Install SDDM theme
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme || {
    echo -e "${RED}Failed to clone SDDM theme!${RESET}"
    exit 1
}

sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

# Configure SDDM theme
echo "[Theme]" | sudo tee /etc/sddm.conf
echo "Current=sddm-astronaut-theme" | sudo tee -a /etc/sddm.conf

echo -e "${GREEN}Installation complete!${RESET}"
if check_nvidia; then
    echo -e "${YELLOW}Please reboot your system to complete the NVIDIA setup.${RESET}"
fi

# Fisher installation
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# FZF installation
yay -S --needed fzf bat fd
fisher install PatrickF1/fzf.fish
