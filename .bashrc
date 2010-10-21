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

# this is safe enough yet still convenient -- stuff that is more critical should
# be changed manually
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

alias ..="cd .."
alias btlaunchmany="btlaunchmany --max_uploads 50 --min_peers 100 --max_initiate 50"
alias cpan="cpanp"
alias edit="emacsclient -a emacs -c"
alias egrep="grep --color=auto"
alias fgrep="grep --color=auto"
alias grep="grep --color=auto"
alias ketchup="ketchup -k ftp://ftp.sunet.se/pub/linux/kernel -r"
alias ls="l"
alias ls="ls -F"
alias lynx="lynx -accept_all_cookies"
alias r="fc -e-"
alias scp="scp -prv"
alias ssh="ssh -v"
alias mr="GIT_PAGER= mr"

# set mock user agent
alias wget="wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20091010 Firefox/3.0.5 (Debian-3.5.3-2)' --random-wait"
# mirror a site -- only following relative links
alias wgetm="wget --mirror --relative --page-requisites --convert-links --html-extension --no-host-directories --directory-prefix=."
# aggressive mirroring; no wait time
alias wgetma="wgetm --wait 0"

#########################################################################
## history

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups

# increase the history size from the default of 500
export HISTFILESIZE=10000
export HISTSIZE=10000

# If set, the value is executed as a command prior to issuing each primary prompt.
export PROMPT_COMMAND='history -a'

#########################################################################
## shell options

# minor errors in the spelling of a directory component in a cd command will be
# corrected
shopt -s cdspell

# If set, bash checks the window size after each command and, if necessary,
# updates the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to history file, don't overwrite
shopt -s histappend

# attempt to save all lines of a multiple-line command in the same history
# entry.  This allows easy re-editing of multi-line commands.
shopt -s cmdhist

# do not overwrite files with redirection >
set -o noclobber

#########################################################################
## prompt

PS1="\n[\t] \u@\h:\w\n\$ "

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
## Colors

if [ "$TERM" != "dumb" ]; then
    # colors for ls
    OS=`uname -a|cut -d" " -f1`
    if [ "$OS" == "FreeBSD" ]; then
        export CLICOLOR=""
        export LSCOLORS="Exfxcxdxbxegedabagacad"

    elif [ "$OS" == "Linux" ]; then
        if [ -e $HOME/.dircolors ]; then
            eval "`dircolors -b $HOME/.dircolors`"
        fi
        alias ls='ls --color=auto -F'
    fi

    # colors for less -- gives colorized man pages
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
fi

