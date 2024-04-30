#!/bin/bash
echo -e "logout\nshutdown\nreboot" | dmenu -i -p "Power:" | {
    read action
    case $action in
        logout) i3-msg exit;;
        shutdown) systemctl poweroff;;
        reboot) systemctl reboot;;
    esac
}
