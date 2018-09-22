# ~skangas/.bashrc

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
# ^ the commented method causes errors with scp
#   therefore we use the if shopt below

# The newer (?) method of detecting an interactive shell.
# This works with Fedora Core 6, and probably most modern versions of
# Linux.
if shopt -q login_shell ; then
    ## XXX: Disabled for now. Do we need it for rtorrent on startup?
    # # Disable xon xoff.
    # stty stop undef
    # stty start undef
    return
fi

# run for both .bashrc and .xsession
. ~/.environment

# workaround until the urxvt package maintainers get their head together
[[ $TERM == "rxvt-256color" ]] &&  export TERM="rxvt"

# be paranoid about it. non-critical stuff can always be changed later
umask 077

# logout root after 600 seconds. why the hell are we root anyways? use sudo
if [ "$( whoami )" == "root" ]; then
    TMOUT="600"
fi

# only allow root to send us messages
mesg n

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

txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
COL="${bldgrn}"
SEP="${txtblu} )--( $COL"
PS1="\n$COL\u@\h$SEP\t$SEP\w\$(parse_git_branch)\n\
$COL\$ ${txtrst}"

#########################################################################
## $TERM specific

case "$TERM" in
    linux*)
        alias emacs='emacs -nw'
        ;;
    screen*)
        # tell screen what program we're running
        PS1=$PS1'\[\033k\033\\\\\]'
        PROMPT_COMMAND=$PROMPT_COMMAND'&& echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    xterm*|rxvt*)
        # set window title
        PROMPT_COMMAND=$PROMPT_COMMAND'&& echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
esac

#########################################################################
## Colors

if [ "$TERM" != "dumb" ]; then
    # colors for ls
    OS=`uname -a|cut -d" " -f1`
    if [ "$OS" == "Linux" ]; then
        if [ -x /usr/bin/dircolors ]; then
            eval "`dircolors -b`"
            alias ls='ls --color=auto -F'
            alias dir='dir --color=auto -F'
            alias vdir='vdir --color=auto -F'

            alias grep='grep --color=auto -F'
            alias fgrep='fgrep --color=auto -F'
            alias egrep='egrep --color=auto'
        fi
    elif [ "$OS" == "FreeBSD" ]; then
        export CLICOLOR=""
        export LSCOLORS="Exfxcxdxbxegedabagacad"
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

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#########################################################################
## Printing at Chalmers

if [ "`hostname`" == "kollontaj" ]; then
    export CUPS_GSSSERVICENAME="HTTP"
fi
# Include Drush bash customizations.
if [ -f "/home/skangas/.drush/drush.bashrc" ] ; then
  source /home/skangas/.drush/drush.bashrc
fi

# Include Drush completion.
if [ -f "/home/skangas/.drush/drush.complete.sh" ] ; then
  source /home/skangas/.drush/drush.complete.sh
fi

# Include Drush prompt customizations.
if [ -f "/home/skangas/.drush/drush.prompt.sh" ] ; then
  source /home/skangas/.drush/drush.prompt.sh
fi

function x {
    /home/skangas/wip/mtmigrate/target/release/mtmigrate $2 $1 ~/download/bittorrent
}
function a {
    /home/skangas/wip/mtmigrate/target/release/mtmigrate $2 $1 ~/download/bittorrent
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
