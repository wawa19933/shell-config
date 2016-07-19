# export ENHANCD_FILTER=fzf
# export ENHANCD_COMMAND=ecd
# export ENHANCD_DISABLE_DOT=1
# export ENHANCD_DISABLE_HYPHEN=1

##
# Prezto
#
# zplug "modules/git", from:prezto, \
      # do:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto;
          # ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto/runcoms/zpreztorc ~/.zpreztorc"
##
# Zim - super fast, Prezto-based
#	(just for link)
zplug "Eriner/zim", use:"init.zsh", \
    hook-build:"ln -rfs templates/zimrc $ZDOTDIR/.zimrc; ln -rfs . ${ZDOTDIR}/.zim; source templates/zlogin"

##
# Theme
#
# zplug "bhilburn/powerlevel9k", use:"", \
#   hook-build:"ln -rs ./powerlevel9k.zsh-theme $ZPLUG_HOME/repos/Eriner/zim/modules/prompt/functions/prompt_powerlevel9k_setup; \
#   ln -rs . $ZPLUG_HOME/repos/Eriner/zim/modules/prompt/external-themes/powerlevel9k"
# zplug "inspectahstack/zsh2000", use:zsh2000.zsh-theme
# zplug "el1t/statusline", \
    # hook-build:"ln -rs prezto/prompt_statusline_setup $ZIM/modules/prompt/themes/statusline.zsh-theme"
##
# Other plugins
#
zplug "b4b4r07/enhancd", use:"init.sh"
zplug "djui/alias-tips"
zplug "ascii-soup/zsh-url-highlighter"
zplug "TBSliver/zsh-plugin-tmux-simple"
zplug "marzocchi/zsh-notify"
# zplug "RobSis/zsh-completion-generator"
# zplug "chrissicool/zsh-bash"
zplug "hlissner/zsh-autopair", nice:10
zplug "wbinglee/zsh-wakatime"
zplug "skx/sysadmin-util"
zplug "bric3/nice-exit-code"
zplug "horosgrisa/mysql-colorize"
# zplug "tevren/gitfast-zsh-plugin"
# zplug "rutchkiwi/copyzshell"
# zplug "arzzen/calc.plugin.zsh"
# zplug "zsh-users/zsh-completions", of:src
# zplug "zsh-users/zsh-autosuggestions", nice:10      # Fish-like autocomplete
# zplug "zsh-users/zsh-history-substring-search", nice:10
# zplug "zsh-users/zsh-syntax-highlighting", nice:10
# zplug "trapd00r/zsh-syntax-highlighting-filetypes", nice:11
# zplug "willghatch/zsh-saneopt"
zplug "voronkovich/mysql.plugin.zsh"
zplug "zlsun/solarized-man"
zplug "mollifier/anyframe"

##
# Oh-my-zsh
#
# zplug "lib/clipboard", from:oh-my-zsh
# zplug "lib/completion", from:oh-my-zsh
# zplug "lib/directories", from:oh-my-zsh
# zplug "lib/git", from:oh-my-zsh
# zplug "lib/grep", from:oh-my-zsh
# zplug "lib/history", from:oh-my-zsh
# zplug "lib/key-bindings", from:oh-my-zsh
# zplug "lib/misc", from:oh-my-zsh
# zplug "lib/functions", from:oh-my-zsh
# zplug "plugins/adb", from:oh-my-zsh #use:"_*"
# zplug "plugins/archlinux", from:oh-my-zsh
# zplug "plugins/bgnotify", from:oh-my-zsh
# zplug "plugins/colored-man-pages", from:oh-my-zsh
# zplug "plugins/colorize", from:oh-my-zsh
# zplug "plugins/common-aliases", from:oh-my-zsh
# zplug "plugins/cp", from:oh-my-zsh
# zplug "plugins/zsh_reload", from:oh-my-zsh
# zplug "plugins/systemd", from:oh-my-zsh
# zplug "plugins/rust", from:oh-my-zsh #, use:"_*"
# zplug "plugins/rsync", from:oh-my-zsh
# zplug "plugins/pip", from:oh-my-zsh #, use:"_*", use:"*.zsh"
# zplug "plugins/nmap", from:oh-my-zsh
# zplug "plugins/history-substring-search", from:oh-my-zsh, use:"zsh-history-substring-search.zsh"
# zplug "plugins/geeknote", from:oh-my-zsh #, use:"_*"
# zplug "plugins/fancy-ctrl-z", from:oh-my-zsh
# zplug "plugins/extract", from:oh-my-zsh, use:"_*", use:"*.zsh"

##
# Load plugins
# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# source plugins and add commands to the PATH
zplug load

# zplug check returns true if the given repository exists
# if zplug check b4b4r07/enhancd; then
#     # setting if enhancd is available
#     export ENHANCD_FILTER=fzf-tmux
# fi
