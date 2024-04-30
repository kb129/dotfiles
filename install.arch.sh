./install.sh
if [ ! -d $HOME/.config ]; then
    mkdir $HOME/.config
fi
if [ ! -d $HOME/.config/i3 ]; then
    mkdir $HOME/.config/i3
fi
ln -s ./config/i3/config $HOME/.config/i3/config
if [ ! -d $HOME/.config/i3blocks ]; then
    mkdir $HOME/.config/i3blocks
fi
ln -s ./config/i3/config $HOME/.config/i3blocks/config
ln -s ./Xmodmap $HOME/.Xmodmap
ln -s ./Xresources $HOME/.Xresources
