#!/bin/bash

# Get list of desktop apps
apps=$(grep -r '^Name=' /usr/share/applications ~/.local/share/applications 2>/dev/null \
    | cut -d= -f2 \
    | sort -u)

# Ask user
query=$(echo "$apps" | rofi -dmenu -p "Search or Launch" -matching fuzzy -i)

# If nothing selected, exit
[ -z "$query" ] && exit

# Check if it's a known app
desktop_file=$(grep -irl "Name=$query" /usr/share/applications ~/.local/share/applications 2>/dev/null | head -n 1)

if [ -n "$desktop_file" ]; then
    app_id=$(basename "$desktop_file" .desktop)
    gtk-launch "$app_id" &
else
    # Not a known app — open search in Brave
    xdg-open "https://search.brave.com/search?q=${query}" &
fi
