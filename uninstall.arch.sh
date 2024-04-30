ROOT=$(cd $(dirname $0); pwd)
$ROOT/uninstall.sh
unlink $HOME/.config/i3/config
unlink $HOME/.config/i3blocks/config
unlink $HOME/.Xmodmap
unlink $HOME/.Xresources
