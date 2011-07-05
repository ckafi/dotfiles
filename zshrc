#Filename: zshrc

#Created: 2008-05-22
#Changed: 2011-07-05

#DESCRIPTION: Zsh startup file.
#Feel free to use any line you want.
#First time: run mkdir ~/.zsh

#Contact: tobias@frilling-online.de

if [[ -e /usr/bin/tmux \
	&& -z $TMUX ]]; then
		if [[ $TERM == 'linux' ]]; then
			exec tmux
		else
			exec tmux -2 new
		fi
fi

loading() {
	1="loading $1..."
	1=${(r:$COLUMNS:)1}
	print -n $1'\r'
}

# {{{ env
loading env
setopt all_export
eval $(dircolors)
PATH="$HOME/bin:$PATH"
# gcc coloring
[[ -d /usr/lib/colorgcc/bin ]] && PATH="/usr/lib/colorgcc/bin:$PATH"
# for remind
DontQueue=1
HISTFILE=$HOME/.zsh/zhistory
HISTSIZE=10000
SAVEHIST=10000
PAGER="less"
LESS="-iJM"
VIEWER=$PAGER
EDITOR="vi"
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

# {{{ options, modloads
loading "options and modules"
setopt \
	auto_pushd \
	correct \
	correct_all \
	extended_glob \
	extended_history \
	glob_complete \
	hist_ignore_all_dups \
	hist_ignore_space \
	list_packed \
	list_types \
	mail_warning  \
	no_hup \
	share_history \
	transient_rprompt \


unsetopt \
	beep \
	clobber \


zmodload zsh/mathfunc
zmodload zsh/complist
autoload zmv
autoload -U compinit && compinit
autoload colors && colors
# }}}

# {{{ prompt
# All prompt and no work makes Tobias a poor boy
# All prompt and no work makes Tobias a poor boy
loading prompt

# add red background if running with privileges
PS1="%(!.%K{red}.)"
# (blue) username@
PS1+="%F{blue}%n%f@"
# (green) hostname:
PS1+="%F{green}%m%k%f:"
# (cyan) path with prefix, truncated to 55 characters
PS1+="%F{cyan}%55<..<%~%<<%f"
# newline if length(prompt)>70
#PS1+="%70(l.
#.)"
# (cyan) :jobs (if any)
PS1+="%1(j.:%F{cyan}%j%f.)"
# (red) :exit code (if >0)
PS1+="%(?..:%F{red}%?%f)"
# % or # based on privileges
PS1+="%# "

PS2="%F{cyan}(%_)%f "
# }}}

# {{{ alias
loading alias
#for i in cd ls; do
	#eval "alias $i=' $i'"
#done

alias -g grep="egrep --color=auto"
alias cp="cp -iv"
alias dirs="dirs -v"
alias inst="yaourt -S"
alias ll="ls -AFhl"
alias ls="ls -F --color=auto"
alias mpdplay="mplayer -nocache -prefer-ipv4 http://maschinenraum:8000"
alias mv="mv -iv"
alias psgrep="ps -ef | grep"
alias remove="yaourt -Rcs"
alias rm="rm -v"
alias rscp="rsync -ahP --no-whole-file --inplace"
alias rsmv="rscp --remove-source-files"
alias se="sudoedit"
alias search="yaourt -Ss"
alias sudo="sudo "
alias update="yaourt -Syua"
alias vimwiki="vim +VimwikiIndex"
alias xext="file-roller"
# }}}

# {{{ key-bindings
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
		bindkey "^[[F"  end-of-line ;;
	
	*rxvt* )
		bindkey "^[[7~" beginning-of-line
		bindkey "^[[8~" end-of-line ;;
esac
# }}}

# {{{ completion
loading completion
# based on jdongs .zshrc v0.2.1
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

# {{{ functions
loading functions
[[ -e /etc/zsh_command_not_found ]] && . /etc/zsh_command_not_found

warn () {
	beep -r 3
	echo "$bg[red]$fg_bold[white] !!! Warning !!! \a"     
}

start stop restart() {
	sudo /etc/rc.d/$1 $0
}

preexec () {
	title $1
}

precmd () {
	title zsh
	if [[ -d .hg || -n $HGDIR ]]; then
		if hgid=$(hg identify -bnt 2>/dev/null); then
			RPROMPT=$hgid
			HGDIR=true
		else
			unset RPROMPT
			unset HGDIR
		fi
	fi
}

title () {
	1=${(V)1}
	1=${(q)1}

	local titleprompt='%m:%2~ '
	titleprompt=${(%)titleprompt}
	titleprompt=""
	
	case $TERM in
		screen*)
			print -n "\ek$titleprompt$1\e\\" ;;
		linux)
			;;
		*)
			print -n "\e]2;$titleprompt$1\a" ;;
	esac
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

scalecpu () {
	if [[ -z $1 ]]; then
		cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
		cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	else
		if [[ $1 == "ondemand" || $1 == "powersave" || $1 == "performance" ]]; then
			echo $1 | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
		else
			echo "$1 is not a governor"
			return 1
		fi
	fi
}

# }}}

# {{{ help
loading help
# Idea stolen from grml

helpglob () {
	echo -e "
	  *      Any string
	  ?      Any Charakter
	  [...]  Set or Range of characters
			 Negotiate with [^...]
	  (...)  grouping
	  x|y    x or y
	  ^x     not x
	  x~y    x, but not y
	  x#     zero or more x
	  x##    one or more x
	  **/x   like (*/)#x

	  Flags with (#X)PATTERN:
	  i      case insensitive
	  cN,M   like {N,M} in regex
	  aN     N errors allowed"
}

helpqual () {
	echo -e "
	Form: (XY) at the end of glob pattern
	/    directories
	.    plain files
	@    symbolic links
	=    sockets
	p    named pipes (FIFOs)
	*    executable plain files (0100)
	%    device files (character or block special)
	%b   block special files
	%c   character special files
	r    owner-readable files (0400)
	w    owner-writable files (0200)
	x    owner-executable files (0100)
	A    group-readable files (0040)
	I    group-writable files (0020)
	E    group-executable files (0010)
	R    world-readable files (0004)
	W    world-writable files (0002)
	X    world-executable files (0001)
	s    setuid files (04000)
	S    setgid files (02000)
	t    files with the sticky bit (01000)
	f{spec} files with access rights matching spec
	u<id>   owned by user <id> (number or name)
	g<id>   owned by group <id> (number or name)
	a<n>    file accessed exactly (n) within (-n)
			or more then (+n) TIME [Mwhms]
	m<n>    like a, but mod time
	L<n>    more (+) or less (-) than <n> bytes
			kn for kb, mn for mb
	^    negate all following qualifiers
	D    setopt GLOB_DOTS for current pattern"
}

helpmodi () {
	echo -e "
	Form (:X:Y)
	a   file name -> absolute path
	c   command name -> absolute path
	e   Remove all but the extension
	h   dirname
	l   lowercase
	p   print, dont execute (histexpn only)
	r   remove file extension
	s/l/r   Substitute r for l (global: s/l/r/:G)
	t   basename
	u   uppercase"
}

helphist () {
	echo -e "
	!   Start a history expansion
	!!  previous command
	!n  command-line n
	!-n command-line minus n
	!str    most recent command starting with str
	!?str?  most recent command containing str
	!#  current command line

	0   The first input word (command).
	n   The nth argument.
	^   The first argument.  That is, 1.
	$   The last argument.
	%   The word matched by (the most recent) ?str search.
	x-y A range of words; x defaults to 0.
	*   All the arguments, or a null value if there are none.
	x*  Abbreviates 'x-$'.
	x-  Like 'x*' but omitting word $.

	^foo^bar    like !!:s^foo^bar"
}
# }}}
