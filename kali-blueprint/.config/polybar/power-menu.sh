#!/bin/bash

choice=$(printf '%s\n' \
    ' Lock' \
    ' Switch User' \
    ' Suspend' \
    ' Reboot' \
    ' Power Off' \
    ' Logout' \
    ' Cancel' |
    rofi -dmenu -i -p "Power Menu")

case "$choice" in
    *Lock)
        i3lock -c 000000
        ;;
    *Switch*)
        dm-tool switch-to-greeter
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Power*)
        systemctl poweroff
        ;;
    *Logout)
        i3-msg exit
        ;;
esac
