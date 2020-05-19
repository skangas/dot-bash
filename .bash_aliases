# ~/.aliases -*- mode: sh -*-

# convenience aliases
alias E="SUDO_EDITOR='emacsclient -c -a emacs' sudoedit"
alias ..="cd .."
alias c="cd"
alias l="ls"
alias sl="ls"
alias la="ls -a"
alias ll="ls -l"
alias lal="ls -al"
alias lrt="ls -rt"
alias hist="history"
alias dff="df -h | egrep -v '^(udev|tmpfs)'"

# aliases for coding ruby on rails
alias rs="./bin/rails server"

alias madd="find $HOME/music/incoming -maxdepth 1 -type d |shuf --random-source=/dev/urandom -n1|mpc add"
alias count_incoming_music_dir="ls -l $HOME/music/incoming | wc -l"

# use nice cal command on Debian
#alias cal="cal -m"

# never use ordinary cpan
alias cpan="cpanp"

# keymaps
alias qwer="setxkbmap se_sv_dvorak"
alias qwert="setxkbmap se_sv_dvorak"
alias qwerty="setxkbmap se_sv_dvorak"
alias å,.p="setxkbmap se"
alias å,.py="setxkbmap se"
alias å,.pyf="setxkbmap se"

alias genpass="apg -c /dev/random -a1 -n1 -m32 -MSNCL"

# various aliases
alias btlaunchmany="btlaunchmany --max_uploads 50 --min_peers 100 --max_initiate 50"
alias edit="emacsclient -a emacs -c"
alias ketchup="ketchup -k ftp://ftp.sunet.se/pub/linux/kernel -r"
alias krbchalmers="kinit -f kangass@CHALMERS.SE"
alias lynx="lynx -accept_all_cookies"
alias mr="GIT_PAGER= mr"
alias offlineimap="offlineimap -l $HOME/.offlineimap.log"
alias papub="pax11publish -e -S"
alias parev="pax11publish  -r"
alias r="fc -e-"
alias rtorrent="ionice -c 3 nice -n 19 rtorrent"
alias scp="scp -prv"
alias ssh="ssh -v"
alias mnt="sudo mount -o uid=`whoami`"
alias myip="curl ipinfo.io"

alias emacs_make_use="./configure && make -j9"
alias emacs_devel="./configure --enable-checking='yes,glyphs' --enable-check-lisp-object-type CFLAGS='-O0 -g3' && make -j9"

# alias latest="find -maxdepth 1 -type f -print0|xargs -r0 ls -tr1|tail -1|tr -d '\n' |xargs -0"
# alias latest_mkcpy="cp -n "`latest`" "`latest|sed -r 's/201[0-9]-[0-1][0-9]-[0-3][0-9]/'"\`date +%Y-%m-%d\`/"`""

# convenience aliases
alias caps="setxkbmap -option ctrl:nocaps"
alias huey="ssh -YAt huey 'screen -DRR'"
alias spotify="wine ~/.wine/drive_c/Program\ Files/Spotify/spotify.exe"

# sprunge
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

play_max_volume() {
    mpc play
    amixer set Master 65536
    amixer sset Master on
    ### specific to huey
    amixer -c0 sset Headphone on
    amixer -c0 sset Front 255
    amixer -c0 sset Surround 39
}

alarm() {
    sleep-until "$@"
    play_max_volume
}

error() {
    echo "$@" >&2
    exit 1;
}

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

print_chalmers() {
    sudo cp /etc/cups/client-chalmers.conf /etc/cups/client.conf
    krbchalmers
}

print_lokalen() {
    sudo cp /etc/cups/client-lokalen.conf /etc/cups/client.conf
    sudo service cups start
}

sleep-until() {
    args="$@"
    now=`date -d "now" +%s`
    then=`date -d "$args" +%s`
    delay=`expr $then - $now`
    echo "Sleeping $delay seconds..."
    sleep $delay
}

svtplaydump() {
    rtmpdump -r `curl -s "$1" | egrep -o rtmp[^,]+ | sort -r | uniq|head -n1` -o $2
}

# set mock user agent
alias wget="wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20091010 Firefox/3.0.5 (Debian-3.5.3-2)' --random-wait"
# mirror a site -- only following relative links
alias wgetm="wget --mirror --no-parent --convert-links --page-requisites --html-extension"
# aggressive mirroring; no wait time
alias wgetma="wgetm --wait 0"

alias joffemount="sshfs sk1917.duckdns.org:/home/skangas /Users/skangas/joffe2/ -o reconnect,follow_symlinks,volname='joffe-SSHFS'"
