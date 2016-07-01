##
# Author:       Sergey Maximov
# Description:  Useful aliases for linux shell
#

# Aliases
alias ip='ip --color'
alias grep='grep --color=always'
alias ls='ls -hF --color=always --group-directories-first'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias less='less -iR'
alias ping='ping -c 5'
alias ..='cd ..'
alias la='ls -Al'
alias ll='ls -Al | less'
alias l='ls -l'
alias lr='ls -R'
alias le='ls -lA --sort=extension'
alias mkdir='mkdir -pv'
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

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

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

alias nmap_open_ports="nmap --open"
alias nmap_list_interfaces="nmap --iflist"
alias nmap_slow="nmap -sS -v -T1"
alias nmap_fin="nmap -sF -v"
alias nmap_full="nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
alias nmap_check_for_firewall="nmap -sA -p1-65535 -v -T4"
alias nmap_ping_through_firewall="nmap -PS -PA"
alias nmap_fast="nmap -F -T5 --version-light --top-ports 300"
alias nmap_detect_versions="nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
alias nmap_check_for_vulns="nmap --script=vulscan"
alias nmap_full_udp="nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
alias nmap_traceroute="nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
alias nmap_full_with_scripts="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all "
alias nmap_web_safe_osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "

# Sysadmin
function retval() {
    if [[ -z $1 ]];then
        echo '.'
    else
        echo $1
    fi
}

function retlog() {
    if [[ -z $1 ]];then
        echo '/var/log/apache2/access.log'
    else
        echo $1
    fi
}

alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1,1n'
alias psmem10='ps -e -orss=,args= | sort -b -k1,1n| head -10'
# get top process eating cpu if not work try excute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr | head -10'
# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

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

# list contents of directories in a tree-like format
if [ -z "\${which tree}" ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

# Sort connection state
sortcons() {
    netstat -nat |awk '{print $6}'|sort|uniq -c|sort -rn
}

# View all 80 Port Connections
con80() {
    netstat -nat|grep -i ":80"|wc -l
}

# On the connected IP sorted by the number of connections
sortconip() {
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
}

# top20 of Find the number of requests on 80 port
req20() {
    netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20
}

# top20 of Using tcpdump port 80 access to view
http20() {
    sudo tcpdump -i eth0 -tnn dst port 80 -c 1000 | awk -F"." '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr |head -20
}

# top20 of Find time_wait connection
timewait20() {
    netstat -n|grep TIME_WAIT|awk '{print $5}'|sort|uniq -c|sort -rn|head -n20
}

# top20 of Find SYN connection
syn20() {
    netstat -an | grep SYN | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -nr|head -n20
}

# Printing process according to the port number
port_pro() {
    netstat -ntlp | grep "$(retval $1)" | awk '{print $7}' | cut -d/ -f1
}

# top10 of gain access to the ip address
accessip10() {
    awk '{counts[$(11)]+=1}; END {for(url in counts) print counts[url], url}' "$(retlog)"
}

# top20 of Most Visited file or page
visitpage20() {
    awk '{print $11}' "$(retlog)"|sort|uniq -c|sort -nr|head -20
}

# top100 of Page lists the most time-consuming (more than 60 seconds) as well as the corresponding page number of occurrences
consume100() {
    awk '($NF > 60 && $7~/\.php/){print $7}' "$(retlog)" |sort -n|uniq -c|sort -nr|head -100
    # if django website or other webiste make by no suffix language
    # awk '{print $7}' "$(retlog)" |sort -n|uniq -c|sort -nr|head -100
}

# Website traffic statistics (G)
webtraffic() {
    awk "{sum+=$10} END {print sum/1024/1024/1024}" "$(retlog)"
}

# Statistical connections 404
c404() {
    awk '($9 ~/404/)' "$(retlog)" | awk '{print $9,$7}' | sort
}

# Statistical http status.
httpstatus() {
    awk '{counts[$(9)]+=1}; END {for(code in counts) print code, counts[code]}' "$(retlog)"
}

# Delete 0 byte file
d0() {
    find "$(retval $1)" -type f -size 0 -exec rm -rf {} \;
}

# gather external ip address
geteip() {
    curl -s -S https://icanhazip.com
}

# determine local IP address
getip() {
    if (( ${+commands[ip]} )); then
        ip addr | grep "inet " | grep -v '127.0.0.1' | awk '{print $2}'
    else
        ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'
    fi
}

# Clear zombie processes
clrz() {
    ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}

# Second concurrent
conssec() {
    awk '{if($9~/200|30|404/)COUNT[$4]++}END{for( a in COUNT) print a,COUNT[a]}' "$(retlog)"|sort -k 2 -nr|head -n10
}
