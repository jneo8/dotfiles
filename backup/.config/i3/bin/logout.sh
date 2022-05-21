#!/usr/bin/env bash

# Manage logout with rofi
# By jmutai@computingforgeeks.com

option=`echo -e "sleep\nlock screen\nlogout\nreboot\npoweroff\nKill user $USER" | rofi -width 500 -dmenu -p system:`

# Case switch

case $option in
    sleep)
        systemctl suspend
        ;;
    'lock screen')
        i3lock-fancy -gp
        ;;
    logout)
        i3-nagbar -t warning -m 'Are you sure you  want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    'kill user $USER')
        loginctl kill-user $USER
        ;;
esac

