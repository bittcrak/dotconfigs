#!/usr/bin/env bash

# Author: https://github.com/x0rzavi
# Description: Powermenu implemented with bmenu
# Dependencies: bemenu, libnotify, elogind
# Theme: Catppuccin


options="󰌾 Lock\n󰍃 Logout\n󰑓 Reboot\n PowerOff\nZz Sleep"

choice=$(echo -e $options| wofi --width 250 --height 250 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

if [[ "$choice" == "lock" ]]; then
    swaylock -c 000000

elif [[ "$choice" == "logout" ]]; then
    swaymsg exit

elif [[ "$choice" == "reboot" ]]; then
    systemctl reboot

elif [[ "$choice" == "poweroff" ]];then
    systemctl poweroff

elif [[ "$choice" == "sleep" ]];then
	systemctl sleep
else
    echo
fi
