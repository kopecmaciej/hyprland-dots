#!/bin/bash

CONFIG="$HOME/.config/waybar/config.jsonc"
STYLE="$HOME/.config/waybar/style.css"

if [[ $(pidof waybar) ]]; then
  kill $(pidof waybar)
  echo $(pidof waybar)
fi

waybar --log-level error --config ${CONFIG} --style ${STYLE}
