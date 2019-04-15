# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# From the info manual: However you set INFOPATH, if its last character is a
# colon, this is replaced by the default (compiled-in) path.
INFOPATH="$HOME/.emacs.d/info:$HOME/usr/share/info:/usr/share/info:$INFOPATH"
export INFOPATH

if [ "$MANPATH" = "" ]; then
    export MANPATH=`manpath`":$HOME/usr/share/man"
fi

# set local path
PATH="$HOME/bin:$HOME/usr/bin:$HOME/.local/bin:$HOME/.cabal/bin:$PATH:$HOME/.gem/ruby/2.3.0/bin"
PATH="$HOME/src/git-annex.linux:$PATH"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
