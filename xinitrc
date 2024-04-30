#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xrandr --output DP-1 --off --output HDMI-1 --off --output DP-2 --primary --mode 1920x1080 --pos 0x1381 --rotate normal --output DP-3 --mode 2560x1440 --pos 1920x0 --rotate left --output DP-4 --off
xset r rate 320 40
feh --no-fehbg --bg-fill '/usr/share/backgrounds/archlinux/small.png'

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec i3 
