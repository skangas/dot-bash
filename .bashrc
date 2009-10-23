# ~skangas/.bashrc

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
# ^ the commented method causes errors with scp
#   therefore we use the if shopt below

# The newer (?) method of detecting an interactive shell.
# This works with Fedora Core 6, and probably most modern versions of
# Linux. 
if shopt -q login_shell ; then
    # Disable xon xoff.
    stty stop undef
    stty start undef
    return
fi

# run for both .bashrc and .xsession
. ~/.environment

umask 022

# logout root after 600 seconds. why the hell are we root anyways? use sudo
if [ "$( whoami )" == "root" ]; then
    TMOUT="600"
fi

# only allow root to send us messages
mesg n

# bash completion
[[ -e '/etc/bash_completion' ]] && source /etc/bash_completion

#########################################################################
## aliases

alias btlaunchmany="btlaunchmany --max_uploads 50 --min_peers 100 --max_initiate 50"
alias cpan="cpanp"
alias edit="emacsclient -a emacs -c"
alias grep="grep --color"
alias ketchup="ketchup -k ftp://ftp.sunet.se/pub/linux/kernel -r"
alias ls="ls -F"
alias lynx="lynx -accept_all_cookies"
alias scp="scp -prv"
alias ssh="ssh -v"
alias wget="wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050221 Firefox/1.0 (Ubuntu)' --random-wait"
alias wgetm="wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050221 Firefox/1.0 (Ubuntu)' -r -N -l inf --no-remove-listing -k -K"

#########################################################################
## environment variables

export EMAIL="stefankangas@gmail.com"

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups

# increase the history size from the default of 500
export HISTFILESIZE=10000
export HISTSIZE=10000

# don't save these commands in history
export HISTIGNORE="ssh *:scp *:ls:top:mount"

# If set, the value is executed as a command prior to issuing each primary prompt.
export PROMPT_COMMAND='history -a'

#########################################################################
## shell options
shopt -s cdspell       # ignore minor typos when using cd
shopt -s checkwinsize  # this should help (?)
shopt -s histappend    # append to history file, don't overwrite
shopt -s cmdhist
set -o noclobber       # do not overwrite files with redirection >

#########################################################################
## prompt

# colors (ugly as hell)
Black="$(tput setaf 0)"
BlackBG="$(tput setab 0)"
DarkGrey="$(tput bold ; tput setaf 0)"
LightGrey="$(tput setaf 7)"
LightGreyBG="$(tput setab 7)"
White="$(tput bold ; tput setaf 7)"
Red="$(tput setaf 1)"
RedBG="$(tput setab 1)"
LightRed="$(tput bold ; tput setaf 1)"
Green="$(tput setaf 2)"
GreenBG="$(tput setab 2)"
LightGreen="$(tput bold ; tput setaf 2)"
Brown="$(tput setaf 3)"
BrownBG="$(tput setab 3)"
Yellow="$(tput bold ; tput setaf 3)"
Blue="$(tput setaf 4)"
BlueBG="$(tput setab 4)"
LightBlue="$(tput bold ; tput setaf 4)"
Purple="$(tput setaf 5)"
PurpleBG="$(tput setab 5)"
Pink="$(tput bold ; tput setaf 5)"
Cyan="$(tput setaf 6)"
CyanBG="$(tput setab 6)"
LightCyan="$(tput bold ; tput setaf 6)"
Normal="$(tput sgr0)" # No Color

#local COLOR1="\[\033[0;36m\]"
#local COLOR2="\[\033[1;36m\]"
#local COLOR3="\[\033[1;30m\]"
#local COLOR4="\[\033[0m\]"

C1="$Normal"
C2="$Normal$Cyan"
C3="$Normal$LightCyan"

PS1="\n$C3[$C1\t$C3] $C1\u@\h$C2:$C1\w\n$C2\$ $C1"

#########################################################################
## $TERM specific

case "$TERM" in
    linux*)
	alias emacs='emacs -nw'
	;;
    xterm*|rxvt*)
	# set window title
	PROMPT_COMMAND=$PROMPT_COMMAND'&& echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
	;;
    screen*)
	# tell screen what program we're running
	PS1=$PS1'\[\033k\033\\\\\]'
	;;
    *)
        ;;
esac

#########################################################################
## colors for less -- gives colorized man pages

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#########################################################################
## Colors for `ls`

OS=`uname -a|cut -d" " -f1`
if [ "$TERM" != "dumb" ]; then
    if [ "$OS" == "FreeBSD" ]; then
        export CLICOLOR=""
        export LSCOLORS="Exfxcxdxbxegedabagacad"
    elif [ "$OS" == "Linux" ]; then
        if [ -e $HOME/.dircolors ]; then
            eval "`dircolors -b $HOME/.dircolors`"
        fi
        alias ls='ls --color=auto -F'
    fi
fi

