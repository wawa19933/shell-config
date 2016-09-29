#!/usr/bin/env bash

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

alias bc='bc -l'

alias mkdir='mkdir -p -v'
alias mv='mv -v'
alias rm='rm -v --one-file-system --preserve-root'

alias ip='ip --color'
alias ipa='ip addr'
alias grep='grep --color=auto'
alias ls='ls -hF --color=always --group-directories-first'
alias df='df -kh'
alias du='du -kh'
alias free='free -h'
alias less='less -iR'
alias ping='ping -c 5'
alias la='ls -Al'
alias ll='ls -Al | less'
alias l='ls -l'
alias lr='ls -R'
alias le='ls -lA --sort=extension'
alias rsync='rsync -h --progress'
alias rsync-copy="rsync -avz"
alias rsync-move="rsync -avz --remove-source-files"
alias rsync-update="rsync -avzu"
alias rsync-synchronize="rsync -avzu --delete"

alias apt="sudo apt"
alias dpkg="sudo dpkg"
alias apt-get="sudo apt-get"
alias aptitude="sudo aptitude"
alias dnf='sudo dnf'
alias yum='sudo yum'
alias pacman='sudo pacman'

# function checks if the application is installed
function __add_command_replace_alias() {
    if [ -x "`which $2 2>&1`" ]; then
        alias $1=$2
    fi
}

if [ -x "`which most 2>&1`" ]; then
    alias less=most
    export PAGER=most
fi

if [ -x "`which vim 2>&1`" ]; then
        export EDITOR=vim
fi

__add_command_replace_alias tail 'multitail'
__add_command_replace_alias df 'pydf'
__add_command_replace_alias traceroute 'mtr'
__add_command_replace_alias tracepath 'mtr'
__add_command_replace_alias top 'htop'

term=$(ps -p $$ | awk '$1 != "PID" {print $(NF)}' | tr -d '()')
# Command line head / tail shortcuts
if [[ "$(basename $term)" == "zsh" ]]; then
    alias -g H='| head'
    alias -g T='| tail'
    alias -g G='| grep'
    alias -g L="| less"
    alias -g M="| most"
    alias -g LL="2>&1 | less"
    alias -g CA="2>&1 | cat -A"
    alias -g NE="2> /dev/null"
    alias -g NUL="> /dev/null 2>&1"
    alias -g P="2>&1| pygmentize -l pytb"

    # Disable globbing
    alias systemctl='noglob systemctl'
    alias find='noglob find'
    alias locate='noglob locate'

    # Systemd
    user_commands=(
      list-units is-active status show help list-unit-files
      is-enabled list-jobs show-environment cat)

    sudo_commands=(
      start stop reload restart try-restart isolate kill
      reset-failed enable disable reenable preset mask unmask
      link load cancel set-environment unset-environment
      edit)

    for c in $user_commands; do
        alias sc-$c="systemctl $c";
    done
    for c in $sudo_commands; do
        alias sc-$c="sudo systemctl $c";
    done
else
    # Systemd
    user_commands=(
      list-units is-active status show help list-unit-files
      is-enabled list-jobs show-environment cat)

    sudo_commands=(
      start stop reload restart try-restart isolate kill
      reset-failed enable disable reenable preset mask unmask
      link load cancel set-environment unset-environment
      edit)

    for c in ${user_commands[@]}; do
        alias sc-$c="systemctl $c";
    done
    for c in ${sudo_commands[@]}; do
        alias sc-$c="sudo systemctl $c";
    done
fi

alias sc-enable-now="sc-enable --now"
alias sc-disable-now="sc-disable --now"
alias sc-mask-now="sc-mask --now"

alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias path='echo -e ${PATH//:/\\n}'
alias x='extract'
alias colorize='colorize_via_pygmentize'

# Useful unarchiver!
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1    ;;
            *.tar.gz)   tar xzf $1    ;;
            *.bz2)      bunzip2 $1    ;;
            *.rar)      rar x $1      ;;
            *.gz)       gunzip $1     ;;
            *.tar)      tar xf $1     ;;
            *.tbz2)     tar xjf $1    ;;
            *.tgz)      tar xzf $1    ;;
            *.zip)      unzip $1      ;;
            *.Z)        uncompress $1 ;;
            *.7z)       7z x $1       ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


colorize_via_pygmentize() {
    if [ ! -x "$(which pygmentize)" ]; then
        echo "package \'pygmentize\' is not installed!"
        return -1
    fi

    if [ $# -eq 0 ]; then
        pygmentize -g $@
    fi

    for FNAME in $@
    do
        filename=$(basename "$FNAME")
        lexer=`pygmentize -N \"$filename\"`
        if [ "Z$lexer" != "Ztext" ]; then
            pygmentize -l $lexer "$FNAME"
        else
            pygmentize -g "$FNAME"
        fi
    done
}


function allcolors() {
    # credit to http://askubuntu.com/a/279014
    for x in 0 1 4 5 7 8; do
        for i in `seq 30 37`; do
            for a in `seq 40 47`; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

# directory LS
dls () {
    ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"
}
psgrep() {
    ps aux | grep "$(retval $1)" | grep -v grep
}
# Kills any process that matches a regexp passed to it
killit() {
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}
