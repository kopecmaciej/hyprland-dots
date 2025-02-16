#!/bin/bash

# Function to check for NVIDIA GPU
check_nvidia() {
    if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
        return 0  # NVIDIA GPU found
    else
        return 1  # NVIDIA GPU not found
    fi
}

# Function to prompt yes/no questions
ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " response
        case $response in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Ask user about NVIDIA
echo "Checking for NVIDIA graphics card..."
if check_nvidia; then
    echo "NVIDIA GPU detected!"
    if ask_yes_no "Would you like to install NVIDIA drivers?"; then
        echo "Installing NVIDIA drivers and dependencies..."
        yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
        
        echo "Configuring NVIDIA modules..."
        sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
        echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
        
        echo "Verifying NVIDIA configuration..."
        if [ "$(cat /etc/modprobe.d/nvidia.conf)" = "options nvidia-drm modeset=1" ]; then
            echo "✓ NVIDIA configuration verified successfully"
        else
            echo "⚠️ NVIDIA configuration verification failed"
            echo "Expected: options nvidia-drm modeset=1"
            echo "Actual: $(cat /etc/modprobe.d/nvidia.conf)"
        fi

        echo "NVIDIA setup complete."
        if ask_yes_no "Would you like to reboot now to complete NVIDIA setup?"; then
            sudo reboot
        else
            echo "Please remember to reboot your system later to complete the NVIDIA setup."
        fi
    fi
fi

# Install essential packages
echo "Installing essential packages..."
sudo pacman -S --needed \
    hyprland \
    waybar \
    rofi-wayland \
    wezterm \
    dolphin \
    xdg-desktop-portal-hyprland \
    sddm \
    swaync \
    swww \
    pipewire \
    pipewire-pulse \
    pipewire-audio \
    wireplumber \
    pavucontrol \
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    noto-fonts-emoji \
    wl-clipboard

## Install essential package that are missing in pacman
sudo pacman -S \
    docker-buildx \
    helm

yay -S \
    hyprshot \
    wlogout

# Ask about additional packages
echo -e "\nAdditional packages available for installation:"

echo "1. Development tools (lazygit, yarn, ripgrep)"
if ask_yes_no "Would you like to install development tools?"; then
    sudo pacman -S --needed lazygit yarn ripgrep
fi

echo "2. Sync tools (rsync, syncthing)"
if ask_yes_no "Would you like to install sync tools?"; then
    sudo pacman -S --needed rsync syncthing
fi

echo "3. Shell enhancements (starship)"
if ask_yes_no "Would you like to install shell enhancements?"; then
    sudo pacman -S --needed starship yazi
fi

echo "4. Additional fonts (ttf-meslo-nerd-font-powerlevel10k)"
if ask_yes_no "Would you like to install additional fonts?"; then
    yay -S ttf-meslo-nerd-font-powerlevel10k
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
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

# Configure SDDM theme
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

echo "Installation complete!"
if check_nvidia; then
    echo "Please reboot your system to complete the NVIDIA setup."
fi

## Fisher

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

### FZF
yay -S fzf bat fd
fisher install PatrickF1/fzf.fish
