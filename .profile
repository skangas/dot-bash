# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# From the info manual: However you set INFOPATH, if its last character is a
# colon, this is replaced by the default (compiled-in) path.
if [ -d "$HOME/.emacs.d/info" ]; then
    INFOPATH="$HOME/.emacs.d/info:$INFOPATH"
    export INFOPATH
fi
if [ -d "$HOME/usr/share/info" ]; then
    INFOPATH="$HOME/usr/share/info:$INFOPATH"
    export INFOPATH
fi


if [ "$MANPATH" = "" ]; then
    export MANPATH=`manpath`":$HOME/usr/man"
fi

# set local path
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$HOME/usr/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
