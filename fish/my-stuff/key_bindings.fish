bind -M insert \cb 'up-or-search'
bind -M insert \ch 'commandline -i $history[1]'
bind -M insert \ck 'history-token-search-backward'
bind -M insert \cl '__fish_list_current_token'
bind -M insert \cp 'commandline -a "| $PAGER"'
bind -M insert \cs '__resudo'
bind \ce 'edit_command_buffer'
