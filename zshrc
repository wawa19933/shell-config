DEFAULT_USER=sergii
RCDIR=${HOME}/.config/shell
POWERLINE_DIR="${HOME}/.local/powerline/powerline"
POWERLINE_ZSH="${POWERLINE_DIR}/bindings/zsh/powerline.zsh"
export ZDOTDIR="${RCDIR}"
export ZPLUG_HOME="$ZDOTDIR/zplug"
export TERM="xterm-256color"
# export LESSOPEN='|~/.lessfilter %s'
# export FZF_DEFAULT_COMMAND='ag -g ""'
# export FZF_DEFAULT_OPTS="--reverse --inline-info"
export GENCOMPL_PY="python2"
# POWERLEVEL9K_INSTALLATION_PATH="$ZPLUG_HOME/repos/bhilburn/powerlevel9k/powerlevel9k.zsh-theme"

# Use cdr (recent cd)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Fuzzy search fzf
if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --all
fi

if [[ -f $HOME/.fzf.zsh ]]; then
    source $HOME/.fzf.zsh
else
    [ -f $HOME/.fzf/shell/completion.zsh ] && source $HOME/.fzf/shell/completion.zsh
    [ -f $HOME/.fzf/shell/key-bindings.zsh ] && source $HOME/.fzf/shell/key-bindings.zsh
fi

#
# Zplug
#
if [[ ! -d $ZDOTDIR/zplug ]]; then
    git clone https://github.com/zplug/zplug $ZDOTDIR/zplug
    source $ZDOTDIR/zplug/init.zsh && zplug update --self
fi
[ -f $ZDOTDIR/zplug/init.zsh ] && source $ZDOTDIR/zplug/init.zsh
[ -f $ZDOTDIR/plugins.zsh ] && source $ZDOTDIR/plugins.zsh

# Prompt
[ -f $ZDOTDIR/promptline.zsh ] && source $ZDOTDIR/promptline.zsh
# [ -f "${POWERLINE_ZSH}" ] && powerline-daemon -q ; source "${POWERLINE_ZSH}"

# Aliases
[ -f $ZDOTDIR/aliases.sh ] && source $ZDOTDIR/aliases.sh

# Key bindings
[ -f $ZDOTDIR/key-bindings.sh ] && source $ZDOTDIR/key-bindings.sh

[ -f $RCDIR/dircolors.256dark ] && eval `dircolors $RCDIR/dircolors.256dark`

# If a parameter name was completed and a following character (normally a space) automatically inserted, and the next character  typed
# is  one  of  those that have to come directly after the name (like `}', `:', etc.), the automatically added character is deleted, so
# that the character typed comes immediately after the parameter name.  Completion in a brace expansion  is  affected  similarly:  the
# added character is a `,', which will be removed if `}' is typed next.
setopt AUTO_PARAM_KEYS

# If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space.
setopt AUTO_PARAM_SLASH

# Whenever a command completion or spelling correction is attempted, make sure the entire command path is hashed  first.   This  makes
# the first completion slower but avoids false reports of spelling errors.
setopt HASH_LIST_ALL

# Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
setopt LIST_PACKED

# When  the current word has a glob pattern, do not insert all the words resulting from the expansion but generate matches as for com‐
# pletion and cycle through them like MENU_COMPLETE. The matches are generated as if a `*' was added  to  the  end  of  the  word,  or
# inserted  at  the  cursor when COMPLETE_IN_WORD is set.  This actually uses pattern matching, not globbing, so it works not only for
# files but for any completion, such as options, user names, etc.
# -- Note that when the pattern matcher is used, matching control (for example, case-insensitive or anchored matching)  cannot  be  used.
# This limitation only applies when the current word contains a pattern; simply turning on the GLOB_COMPLETE option does not have this
# effect.
setopt GLOB_COMPLETE

# Note  the  location  of  each  command the first time it is executed.  Subsequent invocations of the same command will use the saved
# location, avoiding a path search.  If this option is unset, no path hashing is done at all.  However, when CORRECT is set,  commands
# whose names do not appear in the functions or aliases hash tables are hashed in order to avoid reporting them as spelling errors.
setopt HASH_CMDS

# When hashing commands because of HASH_CMDS, check that the file to be hashed is actually an executable.  This  option  is  unset  by
# default  as  if the path contains a large number of commands, or consists of many remote files, the additional tests can take a long
# time.  Trial and error is needed to show if this option is beneficial.
setopt HASH_EXECUTABLES_ONLY

# When  searching for history entries in the line editor, do not display duplicates of a line previously found, even if the duplicates
# are not contiguous.
setopt HIST_FIND_NO_DUPS

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion  is  done  from
# both ends.
unsetopt COMPLETE_IN_WORD

# If a completion is performed with the cursor within a word, and a full completion is inserted,
# the cursor is moved to the end of the word
unsetopt ALWAYS_TO_END

# If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in  the  argument  list.   This
# also applies to file expansion of an initial `~' or `='.
unsetopt NOMATCH


# Powerlevel9k themes
# by tacolizard
#POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_BATTERY_CHARGING='yellow'
# POWERLEVEL9K_BATTERY_CHARGED='green'
# POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
# POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
# POWERLEVEL9K_BATTERY_LOW_COLOR='red'
# POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
# #POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX='\uf0da'
# #POWERLEVEL9K_VCS_GIT_ICON='\ue60a'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
# #POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status battery context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time background_jobs ram virtualenv rbenv rvm)
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
# POWERLEVEL9K_CUSTOM_TIME_FORMAT="%D{\uf017 %H:%M:%S}"
# #POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_PROMPT_ON_NEWLINE=false
###
# by dritter
# POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon load context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
# POWERLEVEL9K_SHOW_CHANGESET=true
# POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
###
# by giladgo
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir node_version vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(longstatus history time)
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S %d/%m/%Y}"
# POWERLEVEL9K_NODE_VERSION_BACKGROUND='022'
###
# by natemccurdy
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
###
# by rjorgenson
# POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\u2517%{%F{default}%} "
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_OS_ICON_BACKGROUND="black"
# POWERLEVEL9K_OS_ICON_FOREGROUND="249"
# POWERLEVEL9K_TODO_BACKGROUND="black"
# POWERLEVEL9K_TODO_FOREGROUND="249"
# POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
# POWERLEVEL9K_DIR_HOME_FOREGROUND="249"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="249"
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"
# POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
# POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
# POWERLEVEL9K_NVM_BACKGROUND="black"
# POWERLEVEL9K_NVM_FOREGROUND="249"
# POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_COLOR="green"
# POWERLEVEL9K_RVM_BACKGROUND="black"
# POWERLEVEL9K_RVM_FOREGROUND="249"
# POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
# POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="black"
# POWERLEVEL9K_LOAD_WARNING_BACKGROUND="black"
# POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
# POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="249"
# POWERLEVEL9K_LOAD_WARNING_FOREGROUND="249"
# POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="249"
# POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
# POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
# POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"
# POWERLEVEL9K_RAM_BACKGROUND="black"
# POWERLEVEL9K_RAM_FOREGROUND="249"
# POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
# POWERLEVEL9K_BATTERY_LOW_BACKGROUND="black"
# POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="black"
# POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="black"
# POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="black"
# POWERLEVEL9K_BATTERY_LOW_FOREGROUND="249"
# POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND="249"
# POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND="249"
# POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="249"
# POWERLEVEL9K_BATTERY_LOW_VISUAL_IDENTIFIER_COLOR="red"
# POWERLEVEL9K_BATTERY_CHARGING_VISUAL_IDENTIFIER_COLOR="yellow"
# POWERLEVEL9K_BATTERY_CHARGED_VISUAL_IDENTIFIER_COLOR="green"
# POWERLEVEL9K_BATTERY_DISCONNECTED_VISUAL_IDENTIFIER_COLOR="249"
# POWERLEVEL9K_TIME_BACKGROUND="black"
# POWERLEVEL9K_TIME_FOREGROUND="249"
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \UE12E"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('status' 'os_icon' 'todo' 'context' 'dir' 'vcs')
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('nvm' 'rvm' 'load' 'ram_joined' 'battery' 'time')
