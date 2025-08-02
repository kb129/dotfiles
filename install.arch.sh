ROOT=$(cd $(dirname $0); pwd)
$ROOT/install.sh
if [ ! -d $HOME/.config ]; then
    mkdir $HOME/.config
fi
if [ ! -d $HOME/.config/i3 ]; then
    mkdir $HOME/.config/i3
fi
ln -s $ROOT/archlinux/i3/config $HOME/.config/i3/config
ln -s $ROOT/archlinux/i3/shutdown_menu.sh $HOME/.config/i3/shutdown_menu.sh
if [ ! -d $HOME/.config/i3blocks ]; then
    mkdir $HOME/.config/i3blocks
fi
ln -s $ROOT/archlinux/i3blocks/config $HOME/.config/i3blocks/config
ln -s $ROOT/archlinux/Xmodmap $HOME/.Xmodmap
ln -s $ROOT/archlinux/Xresources $HOME/.Xresources
