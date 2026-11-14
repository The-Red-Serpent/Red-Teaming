#!/bin/bash

choice=$(printf "󰌾  Lock\n󰒲  Suspend\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown" |
    rofi -dmenu -i -p "Power Menu")

case "$choice" in
*Lock) betterlockscreen -l ;;
*Suspend) betterlockscreen -l && systemctl suspend ;;
*Logout) i3-msg exit ;;
*Reboot) systemctl reboot ;;
*Shutdown) systemctl poweroff ;;
esac
