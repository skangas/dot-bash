# ~/.aliases -*- mode: sh -*-

# convenience aliases
alias ..="cd .."
alias l="ls"
alias sl="ls"

# use nice cal command on Debian
alias cal="ncal -bM"

# never use ordinary cpan
alias cpan="cpanp"

# do not run fetchmail unless the mailfilter runs
alias fetchmail="perl ~/.mailfilter/mail.pl --quit && fetchmail"

# keymaps
alias qwerty="setxkbmap se_sv_dvorak"
alias å,.pyf="setxkbmap se"

# various aliases
alias btlaunchmany="btlaunchmany --max_uploads 50 --min_peers 100 --max_initiate 50"
alias edit="emacsclient -a emacs -c"
alias egrep="grep --color=auto"
alias fgrep="grep --color=auto"
alias grep="grep --color=auto"
alias ketchup="ketchup -k ftp://ftp.sunet.se/pub/linux/kernel -r"
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

