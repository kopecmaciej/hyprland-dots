# 🚀 Hyprland Configuration

A minimal yet functional Wayland desktop environment powered by Hyprland

![](https://img.shields.io/badge/WM-Hyprland-blue)
![](https://img.shields.io/badge/Terminal-WezTerm-green)
![](https://img.shields.io/badge/Launcher-Rofi-orange)
![](https://img.shields.io/badge/Bar-Waybar-yellow)

![Desktop Screenshot](path_to_your_screenshot.png)

## 📦 Components

- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Terminal**: WezTerm
- **Application Launcher**: Rofi
- **Notification Daemon**: Dunst
- **File Manager**: Dolphin
- **Wallpaper**: Hyprpaper

## 🚀 Quick Start

### Install Hyprland

Clone the repository

```bash
git clone https://github.com/kopecmaciej/hyprland-config.git ~/.config/hypr
```

Make the installation script executable

```bash
chmod +x ~/.config/hypr/scripts/install-hypr.sh
```

Run the installation script

```bash
~/.config/hypr/scripts/install-hypr.sh
```

## ⚙️ Key Components

### 📁 Directory Structure

---

```
~/.config/
├── hypr/
│   ├── hyprland.conf
│   ├── scripts/
│   │   └── install-hypr.sh
│   └── README.md
├── waybar/
│   ├── config
│   └── style.css
├── rofi/
│   └── config.rasi
└── wezterm/
    └── wezterm.lua
```

## 🎮 Default Keybindings

### General

- `SUPER + Return` - Open terminal (WezTerm)
- `SUPER + Q` - Close active window
- `SUPER + Space` - Open application launcher (Rofi)
- `SUPER + F` - Toggle fullscreen
- `SUPER + V` - Toggle floating window

### Workspace Management

- `SUPER + [1-9]` - Switch to workspace 1-9
- `SUPER + SHIFT + [1-9]` - Move active window to workspace 1-9
- `SUPER + TAB` - Toggle between recent workspaces

### Window Management

- `SUPER + [H,J,K,L]` - Focus window in direction
- `SUPER + SHIFT + [H,J,K,L]` - Move window in direction
- `SUPER + Mouse Drag` - Move floating window
- `SUPER + Right Mouse Drag` - Resize window

## 🛠️ Customization

### Changing Wallpaper

Edit `~/.config/hypr/hyprland.conf` and modify the hyprpaper configuration.

### Modifying the Status Bar

Edit `~/.config/waybar/config` and `~/.config/waybar/style.css` to customize
Waybar.

### Changing Theme

The configuration uses Catppuccin Mocha theme by default. You can modify theme
settings in:

- WezTerm: `~/.config/wezterm/wezterm.lua`
- Rofi: `~/.config/rofi/config.rasi`

## 📝 Dependencies

Core components:

- hyprland
- waybar
- rofi
- wezterm
- dunst
- hyprpaper
- polkit-kde-agent
- xdg-desktop-portal-hyprland
- dolphin

Additional utilities:

- brightnessctl
- playerctl
- pamixer
