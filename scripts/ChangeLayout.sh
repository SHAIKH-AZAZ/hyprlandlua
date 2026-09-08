#!/usr/bin/env bash
# Cycle layouts: dwindle -> master -> scrolling

notif="$HOME/.config/swaync/images/ja.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq -r '.str')

case "$LAYOUT" in

"dwindle")
    hyprctl keyword general:layout master

    hyprctl keyword unbind SUPER,J
    hyprctl keyword unbind SUPER,K
    hyprctl keyword unbind SUPER,O

    hyprctl keyword bind SUPER,J,layoutmsg,cyclenext
    hyprctl keyword bind SUPER,K,layoutmsg,cycleprev

    notify-send -e -u low -i "$notif" " Master Layout"
    ;;

"master")
    hyprctl keyword general:layout scrolling

    hyprctl keyword unbind SUPER,J
    hyprctl keyword unbind SUPER,K

    hyprctl keyword bind SUPER,J,movefocus,l
    hyprctl keyword bind SUPER,K,movefocus,r

    notify-send -e -u low -i "$notif" " Scrolling Layout"
    ;;

"scrolling")
    hyprctl keyword general:layout dwindle

    hyprctl keyword unbind SUPER,J
    hyprctl keyword unbind SUPER,K

    hyprctl keyword bind SUPER,J,cyclenext
    hyprctl keyword bind SUPER,K,cyclenext,prev

    notify-send -e -u low -i "$notif" " Dwindle Layout"
    ;;

esac
