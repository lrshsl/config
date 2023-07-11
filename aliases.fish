function clear_screen
	clear && echo
end

abbr c		clear_screen
abbr q		exit
abbr rbt	reboot
abbr po		poweroff
abbr get	'sudo pacman -S'
abbr upd	'sudo pacman -Syyu --noconfirm'
abbr rem	'sudo pacman -Rns'

abbr find	fd
abbr grep	rg

alias l		'exa'
alias ls	'exa -a'
alias la	'exa -la'
alias lst	'exa -aT'
alias lst2	'exa -aT -L 2'
alias lst3	'exa -aT -L 3'
alias lst4	'exa -aT -L 4'
alias lst5	'exa -aT -L 5'

