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
PATH="$HOME/bin:$HOME/usr/bin:$HOME/.cabal/bin:$PATH"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
