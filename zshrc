#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias
alias la='ls -la'
alias ll='ls -l'

export PATH="$PATH:/Users/daikiokonogi/dev/flutter/bin"
export PATH="$PATH:$HOME/.nodebrew/current/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"

#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#	exec startx
#fi

# tmux
# if ! [[ -n $TMUX && $- == *l* ]]; then
#	ID="`tmux list-sessions`"
#	if [[ -z "$ID" ]]; then
#		tmux new-session
#	else
#		create_new_session="Create New Session"
#		ID="$ID\n${create_new_session}:"
#		ID="`echo $ID | fzf --select-1 | cut -d: -f1`"
#		if [[ "$ID" = "${create_new_session}" ]]; then
#			tmux new-session
#		elif [[ -n "$ID" ]]; then
#			tmux attach-session -t "$ID"
#		fi
#	fi
# fi

