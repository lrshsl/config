# Dependencies:
# `exa ripgrep fd dust zoxide`
#
# Optional:
# `most ytop tealdeer`


### Terminal ###
function clear_screen
	clear && echo
end

abbr c			clear_screen
abbr q			exit
abbr rbt		reboot
abbr po			poweroff

### Pacman ###
abbr get		'sudo pacman -S'
abbr upd		'sudo pacman -Syyu --noconfirm'
abbr rem		'sudo pacman -Rns'

### Fish ###
abbr fn			'funced -e nvim -s'

function last_history_item
    echo $history[1]
end
abbr !! --position anywhere --function last_history_item
abbr -p=anywhere --set-cursor=' ' hm '~/ '		# Home: But adds two spaces after cursor

### Remind (and force) me to use the good (and rusty) tools ###
abbr grep		rg
abbr find		fd
abbr less		'most or more or less'
abbr htop		'ytop or htop'
abbr du			dust
abbr ncdu		dust
abbr man 		'tldr or man'
alias z  		zoxide
abbr cd 		z


### ls or tree ###


