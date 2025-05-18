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
    echo "\$monitor_1=Eizo Nanao Corporation EV2450 91296017" >> "$monitor_conf_file"
    echo "\$monitor_2=Eizo Nanao Corporation EV2450 46842037" >> "$monitor_conf_file"
    echo "workspace=1,monitor:desc:\$monitor_1" >> "$monitor_conf_file"
    echo "monitor=desc:\$monitor_1,1920x1080@60,0x0,1" >> "$monitor_conf_file"
    echo "monitor=desc:\$monitor_2,1920x1080@60,1920x0,1" >> "$monitor_conf_file"

elif monitor_exists "Iiyama"; then
    echo "\$monitor_1=DP-1" >> "$monitor_conf_file"
    echo "\$monitor_2=HDMI-A-1" >> "$monitor_conf_file"
    echo "workspace=1,monitor:\$monitor_1" >> "$monitor_conf_file"
    echo "monitor=\$monitor_1,3440x1440@100,0x0,1" >> "$monitor_conf_file"
    echo "monitor=\$monitor_2,1920x1080@144,3440x0,1" >> "$monitor_conf_file"

elif monitor_exists "TCL SMART TV"; then
    echo "workspace=eDP-1,1" >> "$monitor_conf_file"
    echo "monitor=eDP-1, preferred, 0x0, 2" >> "$monitor_conf_file"
    echo "monitor=HDMI-A-1, 1920x1080@60, 2880x0, 1" >> "$monitor_conf_file"

else
    # Fallback for laptop-only mode
    echo "monitor=eDP-1, preferred, 0x0, 2" >> "$monitor_conf_file"
fi

