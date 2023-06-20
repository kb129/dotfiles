#!/bin/sh
updatenum=$({checkupdates; paru -Qua} | wc -l)

case $updatenum in
	0) echo 'System is up to date' ;;
	1) echo '$updatenum update available';;
	*) echo '$updatenum updates available';;
esac
