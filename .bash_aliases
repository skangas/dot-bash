# ~/.aliases -*- mode: sh -*-

# convenience aliases
alias ..="cd .."
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias sl="ls"

# use nice cal command on Debian
#alias cal="ncal -bM" # not in squeeze :(

# never use ordinary cpan
alias cpan="cpanp"

# do not run fetchmail unless the mailfilter runs
alias fetchmail="perl ~/.mailfilter/mail.pl --quit && fetchmail"

# keymaps
alias qwer="setxkbmap se_sv_dvorak"
alias qwert="setxkbmap se_sv_dvorak"
alias qwerty="setxkbmap se_sv_dvorak"
alias å,.p="setxkbmap se"
alias å,.py="setxkbmap se"
alias å,.pyf="setxkbmap se"

# various aliases
alias btlaunchmany="btlaunchmany --max_uploads 50 --min_peers 100 --max_initiate 50"
alias edit="emacsclient -a emacs -c"
alias ketchup="ketchup -k ftp://ftp.sunet.se/pub/linux/kernel -r"
alias krbchalmers="kinit -f kangass@CHALMERS.SE"
alias lynx="lynx -accept_all_cookies"
alias mr="GIT_PAGER= mr"
alias papub="pax11publish -e -S"
alias parev="pax11publish  -r"
alias r="fc -e-"
alias rtorrent="ionice -c 3 nice -n 19 rtorrent"
alias scp="scp -prv"
alias ssh="ssh -v"

# git
git-fake-repos() {
    if [ "x$1" != "x" ]; then
        git init --bare $1.git
        echo "Fake bare repos (core.worktree = ../../, core.bare = false)"
        cd $1.git
        git config core.worktree ../../
        git config core.bare false
        cd -
    else
        echo "Please specify a target directory"
    fi
}

lowest() {
    TARGET_PID="`pidof $1`"
    if [ "$TARGET_PID" != "" ]; then
        renice -n 19 -p $TARGET_PID
        ionice -c 3  -p $TARGET_PID
    fi
}

# set mock user agent
alias wget="wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20091010 Firefox/3.0.5 (Debian-3.5.3-2)' --random-wait"
# mirror a site -- only following relative links
alias wgetm="wget --mirror --no-parent --convert-links --page-requisites --html-extension"
# aggressive mirroring; no wait time
alias wgetma="wgetm --wait 0"
