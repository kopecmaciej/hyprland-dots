#!/bin/bash

monitor_conf_file="$HOME/.config/hypr/monitors.conf"

# Get current monitors
monitors=$(hyprctl monitors)

# Function to check if a monitor exists
monitor_exists() {
    echo "$monitors" | grep -q "$1"
}

# Clear the config file first
> "$monitor_conf_file"

if monitor_exists "Eizo"; then
    echo "monitor=eDP-1, disable" >> "$monitor_conf_file"
    echo "workspace=1,monitor:desc:Eizo Nanao Corporation EV2450 91296017" >> "$monitor_conf_file"
    echo "monitor=desc:Eizo Nanao Corporation EV2450 91296017, preferred, 0x0, 1" >> "$monitor_conf_file"
    echo "monitor=desc:Eizo Nanao Corporation EV2450 46842037, preferred, 1920x0, 1" >> "$monitor_conf_file"

elif monitor_exists "TCL SMART TV"; then
    echo "workspace=eDP-1,1" >> "$monitor_conf_file"
    echo "monitor=eDP-1, preferred, 0x0, 2" >> "$monitor_conf_file"
    echo "monitor=HDMI-A-1, 1920x1080@60.00Hz, 2880x0, 1" >> "$monitor_conf_file"

elif monitor_exists "Iiyama"; then
    echo "monitor=eDP-1, disable" >> "$monitor_conf_file"
    echo "workspace=1,monitor:desc:Iiyama North America PL3466WQ 1174011100738," >> "$monitor_conf_file"
    echo "monitor=desc:Iiyama North America PL3466WQ 1174011100738, preferred, 0x0, 1" >> "$monitor_conf_file"
    echo "monitor=desc:AOC 24G2W1G4 0x0000AC49, preferred, 3440x0, 1" >> "$monitor_conf_file"

else
    # Fallback for laptop-only mode
    echo "monitor=eDP-1, preferred, 0x0, 2" >> "$monitor_conf_file"
fi

