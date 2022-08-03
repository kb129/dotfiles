# if bash does not exist, return
[ "$BASH" = "" ] &&  return

if [ -z "$PS1" ]; then
    return
fi

# read system global settings
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# read common settings
if [ -f ../bashrc ]; then
    source ../bashrc
fi

function share_history {
    history -a
    history -c
    history -r
}

# screen style
if [ "`echo $TERM | grep 'screen'`" != "" ]; then
    ## PWD when no command is running, otherwise current command name as window name
    #export PS1='\u@\h:\W\$ '
    export PS1='\[\033[01;35m\]\u@\h:\W\$\[\033[00m\] '
    export PROMPT_COMMAND='echo -ne "\033k\033\0134\033k$(basename $(pwd))\033\\";share_history'
else
    #export PS1='\u@\h:\W\$ '
    export PS1='\[\033[01;35m\]\u@\h:\W\$\[\033[00m\] '
    export PROMPT_COMMAND='share_history'
fi

stty sane
if [ "$(stty | grep erase)" = "" ] ; then
    stty erase ^H
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTCONTROL=ignoredups
export HISTIGNORE="pwd*:fg*:bg*"
#export HISTIGNORE="cd*:pwd*:fg*:bg*"
export HISTSIZE=10000

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias la='ls -aF'
alias sc='screen -D -RR'
alias lv='lv -Ou8'
# git aliases
alias g='git'
alias gbra='git branch'
alias gchk='git checkout'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -F- << EOM'

export EDITOR='vi'
export SVN_SSH='ssh -q'

# OS-dependent settings
if [ "$(uname)" == 'Darwin' ]; then
    export LSCOLORS=gxfxcxdxbxegedabagacad
    alias ls='ls -G'

    # bash completion
    if [ -f /usr/local/etc/bash_completion ]; then
        source /usr/local/etc/bash_completion
    fi

    # Homebrew PATH
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/include:$PATH
    
    alias Emacs='open -a /Applications/Emacs.app'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    alias gtkwave-app='open -a /Applications/gtkwave.app'
    
elif [ "$(uname)" == 'Linux' ]; then
    LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.i386.rpm=01;31:*.src.rpm=01;30:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:' ; export LS_COLORS
    alias ls='ls --color=auto -NF --show-control-chars'

    # bash completion
    if [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
    
    # ssh-agent
    SSH_AGENT_FILE="${HOME}/.ssh/.ssh-agent.`hostname`"
    if [ -f ${SSH_AGENT_FILE} ]; then
        eval `cat ${SSH_AGENT_FILE}`
        ssh_agent_exist=0    
        for id in `ps ax|grep 'ssh-agent'|sed -e 's/\([0-9]\+\).*/\1/'`
        do 
            if [ ${SSH_AGENT_PID} = ${id} ]
            then 
                ssh_agent_exist=1
            fi
        done
        if [ $ssh_agent_exist = 0 ]
        then
            rm -f ${SSH_AGENT_FILE}
            ssh-agent > ${SSH_AGENT_FILE}
            chmod 600 ${SSH_AGENT_FILE}
            eval `cat ${SSH_AGENT_FILE}`
            ssh-add
        fi
    else
        ssh-agent > ${SSH_AGENT_FILE}
        chmod 600 ${SSH_AGENT_FILE}
        eval `cat ${SSH_AGENT_FILE}`
        ssh-add
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\]\[\e[37m\]:\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[36m\]\`parse_git_branch\`\[\e[m\]\[\e[33m\]\\$\[\e[m\] "
