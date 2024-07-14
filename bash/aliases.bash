
# Dependencies:
# `exa ripgrep fd dust zoxide`
#
# Optional:
# `most ytop tealdeer`



### Terminal ###
clear_screen() {
	clear && echo
}

alias c="clear_screen"
alias q="exit"
alias rbt="reboot"
alias po="poweroff"

alias n="nvim ."
alias nv="neovide ."

alias mr="make run"
alias cr="cargo run --"

### Pacman ###
alias get='sudo pacman -S'
alias up='sudo pacman -Syyu --noconfirm'
alias rem='sudo pacman -Rns'

# Uninstall orphaned packages
alias autoremove='sudo pacman -Rns $(pacman -Qtdq)'

### Git ###
alias g="git"
alias go="git checkout"
alias ga="git add ."
alias gm='git commit -m'
alias gp='tok_gt && git push'
alias gd="git diff"
alias gs="git status"

# - /proc/sys/kernel/
core_dump() {
	cd /proc/sys/kernel
	fzf
	cd -
}


### ls or tree ###

# Make exa show icons by default
alias exa='exa --icons'

lstree() {
	[[ $# -eq 0 ]] && {
		exa -TL 1 2> /dev/null			\
		|| tree -CL 1 2> /dev/null		\
		|| ls -l								\
		|| return 1
		return 0
	}
	exa -TL $1 2> /dev/null				\
	|| exa -TL 1 $							\
	|| tree -CL $1 2> /dev/nul			\
	|| tree -CL 1 $@						\
	|| ls -l $@								\
	|| return 1
}


#-- List version --#

alias l='exa'
alias ls='exa -l'
alias la='exa -la'
alias lst="lstree"
alias t="lstree"


#-- Tree version --#

alias l="lstree"
alias ls="lstree 2"
alias la="lstree 1 -la"
alias lst="lstree 3"
alias t="broot"


#-- Common --#

alias l1="lstree 1"
alias l2="lstree 2"
alias l3="lstree 3"
alias l4="lstree 4"
alias l5="lstree 5"



