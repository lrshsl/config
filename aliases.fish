function clear_screen
	clear && echo
end

abbr c			clear_screen
abbr q			exit
abbr rbt		reboot
abbr po			poweroff
abbr get		'sudo pacman -S'
abbr upd		'sudo pacman -Syyu --noconfirm'
abbr rem		'sudo pacman -Rns'
abbr fn			'funced -e nvim -s'

abbr find		fd
abbr grep		rg

alias t			'exa -TL 1'

alias l			'exa -l'
alias ll		'exa -lah'
alias ls		'exa -la'
alias la		'exa -la'
alias lst		'exa -aT'
alias l2		'exa -aT -L 2'
alias l3		'exa -aT -L 3'
alias l4		'exa -aT -L 4'
alias l5		'exa -aT -L 5'

