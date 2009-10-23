# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# From the info manual: However you set INFOPATH, if its last character is a
# colon, this is replaced by the default (compiled-in) path.
if [ -d "$HOME/.emacs.d/info" ]; then
    INFOPATH="$HOME/.emacs.d/info:"
    export INFOPATH
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set local bin
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
