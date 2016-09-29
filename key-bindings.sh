term=$(ps -p $$ | awk '$1 != "PID" {print $(NF)}' | tr -d '()')
if [[ "$(basename $term)" == "bash" ]]; then
    # alternate mappings for "up" and "down" to search the history
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    # bind 'set show-all-if-ambiguous on'
fi

if [[ "$(basename $term)" == "zsh" ]]; then
    bindkey "^[OH" beginning-of-line 
    bindkey "^[OF" end-of-line
    bindkey "^[[3;5~" delete-word
    # bindkey "^?" backward-delete-word

    # Bind Ctrl+Space for autosuggest accept
    bindkey '^ ' autosuggest-accept

    # AnyFrame key bindings
    bindkey '^xb' anyframe-widget-cdr
    bindkey '^x^b' anyframe-widget-checkout-git-branch
    
    bindkey '^xr' anyframe-widget-execute-history
    bindkey '^x^r' anyframe-widget-execute-history
    
    bindkey '^xi' anyframe-widget-put-history
    bindkey '^x^i' anyframe-widget-put-history
    
    bindkey '^xk' anyframe-widget-kill
    bindkey '^x^k' anyframe-widget-kill
    
    bindkey '^xe' anyframe-widget-insert-git-branch
    bindkey '^x^e' anyframe-widget-insert-git-branch
fi