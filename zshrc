# A zsh start-up file
# Written by Tobias Frilling (tobias@frilling-online.de)
# Released under CC0 (Public Domain)
# http://creativecommons.org/publicdomain/zero/1.0/
# So feel free to use any line you want.
# First time: run mkdir ~/.zsh

# Start tmux {{{
if [[ -e /usr/bin/tmux \
	&& -z $TMUX \
	&& -z $SUDO_UID ]]; then
		if [[ $TERM == 'linux' ]]; then
			exec tmux
		else
			exec tmux -2 new
		fi
fi
# }}}

# Miscellaneous {{{
# print a 'loading foo' message
loading() {
	1="loading $1..."
	1=${(r:$COLUMNS:)1}
	print -n $1'\r'
}
loading Miscellaneous
# for z
[[ -e /etc/profile.d/z.sh ]] && \
	source /etc/profile.d/z.sh && \
	Z=true
# syntax highlighting
[[ -e /usr/share/zsh/plugins/zsh-syntax-highlight/zsh-syntax-highlighting.zsh ]] && \
	source /usr/share/zsh/plugins/zsh-syntax-highlight/zsh-syntax-highlighting.zsh
# }}}

# Environment {{{
loading environment
setopt all_export
eval $(dircolors)
PATH="$HOME/bin:$PATH"
# gcc coloring
[[ -d /usr/lib/colorgcc/bin ]] && PATH="/usr/lib/colorgcc/bin:$PATH"
HISTFILE=$HOME/.zsh/zhistory
HISTSIZE=10000
SAVEHIST=10000
PAGER="less"
LESS="-iJM"
VIEWER=$PAGER
EDITOR="vim"
VISUAL=$EDITOR
MAILPATH="/var/mail/${USER};/var/spool/mail/${USER}"
NULLCMD="cat"
READNULLCMD=$PAGER
WORDCHARS+=":"
#really annoying!
#WATCH=all
#WATCHFMT="%S%B%T: %n has %a (%M)"
unsetopt all_export
# }}}

# Options and modules {{{
loading 'options and modules'

ZOPTS=(
	'auto_pushd'
	'no_beep'
	'no_clobber'
	'correct'
	'correct_all'
	'extended_glob'
	'extended_history'
	'glob_complete'
	'hist_ignore_all_dups'
	'hist_ignore_space'
	'list_packed'
	'list_types'
	'mail_warning'
	'no_hup'
	'share_history'
	'transient_rprompt'
)

setopt $ZOPTS
unset ZOPTS

zmodload zsh/mathfunc
zmodload zsh/complist
autoload zmv
autoload -U compinit && compinit
autoload colors && colors
# }}}

# Prompt {{{
# All prompt and no work makes Tobias a poor boy
# All prompt and no work makes Tobias a poor boy
loading prompt

# add red background if running with privileges
PS1="%(!.%K{red}.)"
# username@
PS1+="%F{161}%n%k%f@"
# hostname:
PS1+="%F{208}%m%f:"
# path with prefix, truncated to 55 characters
PS1+="%F{118}%55<..<%~%<<%f"
# newline if length(prompt)>70
#PS1+="%70(l.
#.)"
# :jobs (if any)
PS1+="%1(j.:%F{118}%j%f.)"
# :exit code (if >0)
PS1+="%(?..:%F{196}%?%f)"
# % or # based on privileges
PS1+="%# "

PS2="%F{118}(%_)%f "
# }}}

# Aliases {{{
loading aliases
#for i in cd ls; do
	#eval "alias $i=' $i'"
#done

alias g="git status -sb"
alias -g grep="egrep --color=auto"
alias cp="cp -iv"
alias dirs="dirs -v"
alias ll="ls -AFhl"
alias ls="ls -F --color=auto"
alias mc="mc -x"
alias mpdplay="mplayer -nocache -prefer-ipv4 http://maschinenraum:8000"
alias mv="mv -iv"
alias pacman="pacman-color "
alias psgrep="ps -ef | grep"
alias rm="rm -v"
alias rscp="rsync -ahP --no-whole-file --inplace"
alias rsmv="rscp --remove-source-files"
alias rvim="gvim --remote-silent"
alias sctl="systemctl"
alias sudo="sudo "
alias t="task"
alias ts="rlwrap -i -r -C task task shell"
alias vimwiki="vim +VimwikiIndex"
# }}}

# Key-bindings {{{
loading key-bindings

bindkey -v    # Vi-Keymap

#From the GRML-Zshrc: ^P inserts last typed word.
insert-last-typed-word() { zle insert-last-word -- 0 -1 }
zle -N insert-last-typed-word
bindkey "^P"    insert-last-typed-word
bindkey "^B"    insert-last-word
bindkey "^[[5~" history-beginning-search-backward       # PgUp
bindkey "^[[6~" history-beginning-search-forward        # PgDown
bindkey "^E"    push-input
bindkey "^H"    run-help
bindkey "^[[3~" vi-delete-char                          # Del
bindkey "^R"    history-incremental-search-backward


# for vicmd-keymap
bindkey -a "u"  undo
bindkey -a "^R" redo

case $TERM in
	linux | screen* )
		bindkey "^[[1~" beginning-of-line
		bindkey "^[[4~" end-of-line ;;
	
	xterm* )
		bindkey "^[[H"  beginning-of-line
		bindkey "^[[F"  end-of-line
		bindkey "^H"    vi-backward-delete-char ;;
	
	*rxvt* )
		bindkey "^[[7~" beginning-of-line
		bindkey "^[[8~" end-of-line ;;
esac
# }}}

# Completions {{{
loading completions
# based on jdongs .zshrc v0.2.1
# TODO: Figure our what exactly this all does.
# No more cargo-culting.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# insert all expansions for expand completer
#zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
#zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## ignore completion functions (until the _ignored completer)
#zstyle ':completion:*:functions' ignored-patterns '_*'
#zstyle ':completion:*:*:*:users' ignored-patterns \
	#adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
	#named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
	#rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
	#avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
	#firebird gnats haldaemon hplip irc klog list man cupsys postfix\
	#proxy syslog www-data mldonkey sys snort
# }}}

# Functions {{{
loading functions
[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found

warn () {
	beep -r 3
	echo "$bg[red]$fg_bold[white] !!! Warning !!! \a"     
}

preexec () {
	title $1
}

precmd () {
	#for z
	[[ -n $Z ]] && _z --add "$(pwd -P)"
	title 'zsh %2~'
	if git branch &>/dev/null; then
		update_git_prompt
		RPROMPT=$git_prompt
	else
		unset RPROMPT
	fi
}

title () {
	1=${(%)1}
	1=${(V)1}
	1=${(q)1}

	case $TERM in
		screen*)
			print -n "\ek$1\e\\" ;;
		linux)
			;;
		*)
			print -n "\e]2;$1\a" ;;
	esac
}

update_git_prompt () {
	local git_status
	local git_branch_name
	local git_branch_status
	local git_commit_hash
	local git_tlights

	git_status=$(git status)

	[[ $git_status =~ '# Initial commit' ]] && \
		git_branch_name="Initial"

	if [[ -z $git_branch_name ]]; then
		git_branch_name=$(git branch | grep '^\*' | sed 's/* //')
		git_commit_hash=$(git rev-parse --short HEAD)
	fi

	if [[ $git_status =~ '# Your branch and .* have diverged' ]]; then
		git_branch_status='d'
	elif [[ $git_status =~ '# Your branch is ahead of ' ]]; then
		git_branch_status='a'
	elif [[ $git_status =~ '# Your branch is behind ' ]]; then
		git_branch_status='b'
	fi

	[[ $git_status =~ "# Changes to be committed:" ]] && \
		git_tlights+="%F{green}s"
	[[ $git_status =~ "# Changes not staged for commit:" ]] && \
		git_tlights+="%F{yellow}m"
	[[ $git_status =~ "# Untracked files:" ]] && \
		git_tlights+="%F{red}u"

	git_prompt="%F{green}$git_branch_name"
	git_prompt+="%F{red}${git_branch_status:+ $git_branch_status}"
	git_prompt+="%F{yellow}${git_commit_hash:+ $git_commit_hash}"
	git_prompt+="${git_tlights:+ }$git_tlights%f"
}

ext () {
	for file in $@; do
		if [[ -f $file ]]; then
			case ${(L)file} in
				*.tar.lrz)           lrzuntar $file ;;
				*.lrz)               lrzip -d $file ;;
				*.tar*|*.tgz|*.tbz)  tar -xvf $file ;;
				*.bz2)               bunzip2 $file ;;
				*.gz|*.z)            gunzip $file ;;
				*.zip|*.cbz)         unzip $file ;;
				*.rar|*.cbr)         unrar x $file ;;
				*.xz)                unxz $file ;;
				*) echo "'$file' Error. Please go away" ;;
			esac
		else
			echo "'$file' is not a valid file"
		fi
	done
}

up () {
	local ups=""
	if [[ -z $1 ]]; then
		1=1
	fi

	for i in {1..$1}; do
		ups=$ups"../"
	done
	cd $ups
}

cd () {
	if [[ $# -ge 3 ]]; then
		echo cd: too many arguments >&2
		return 1
	elif [[ $# -eq 2 ]]; then
		builtin cd $1 $2
	elif [[ $# -eq 1 ]]; then
		if [[ -f $1 ]]; then
			builtin cd $1:h
		else
			builtin cd $1
		fi
	else
		builtin cd
	fi
}
# }}}
