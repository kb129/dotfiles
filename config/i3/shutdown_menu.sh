#!/bin/bash
echo -e "sleep\nlogout\nshutdown\nreboot" | dmenu -i -p "Power:" | {
    read action
    case $action in
        sleep) systemctl suspend;;
        logout) i3-msg exit;;
        shutdown) systemctl poweroff;;
        reboot) systemctl reboot;;
    esac
}
