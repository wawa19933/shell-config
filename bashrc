##
# Author:   Sergey Maximov
# Description: comfortable Bash shell configuration
#
set +v
RCDIR=${HOME}/.config/shell
export HISTSIZE=20000
export HISTFILESIZE=50000
export HISTCONTROL="ignoreboth:ignoredups:erasedups"
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*";
shopt -s histappend
shopt -s histreedit;
shopt -s checkwinsize
shopt -s cdspell
shopt -s autocd

# Save and reload history after each command finishes
export PROMPT_COMMAND="history -a; history -n;"
export TERM="xterm-256color"
export CLICOLOR_FORCE
export PS1="$(tput setaf 1)\w\n\[$(tput bold)\]\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 5)\]\[$(tput setaf 7)\]\\$\[$(tput sgr0)\] "

if [ -t 1 ]; then
	# alternate mappings for "up" and "down" to search the history
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
	# <Tab> will append possible values and suggests variants, if ambiguous,
	# no need <Tab><Tab>
	# bind 'set show-all-if-ambiguous on'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f $RCDIR/aliases.sh ] && source $RCDIR/aliases.sh
[ -f $RCDIR/dircolors.256dark ] && eval `dircolors $RCDIR/dircolors.256dark`
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# if [[ ! -d ~/.fzf ]]; then
# 	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# 	bash ~/.fzf/install
# fi

