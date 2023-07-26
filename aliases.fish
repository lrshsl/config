# Dependencies:
# `exa ripgrep fd dust zoxide`
#
# Optional:
# `most ytop tealdeer`


# Make exa show icons by default
alias exa 'exa --icons'


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
abbr less		'most; or more; or less'
abbr sed		'sd; or sed'
abbr htop		'ytop; or htop'
abbr du			dust
abbr ncdu		dust
abbr man 		'tldr; or man'
alias z  		zoxide
abbr cd 		z


### ls or tree ###


function lstree
	if test (count $argv) = 0
		exa -TL 1 2> /dev/null
		or tree -CL 1 2> /dev/null
		or ls -l
	else
		exa -TL $argv 2> /dev/null
		or exa -TL 1 $argv

		or tree -CL $argv 2> /dev/null
		or tree -CL 1 $argv

		or ls -l $argv
	end
end


#-- List version --#

abbr l			'exa'
abbr ls			'exa -l'
abbr la			'exa -la'
abbr lst		lstree
abbr t			lstree


#-- Tree version --#

abbr l			lstree
abbr ls			lstree 2
abbr la 		lstree 1 -la
abbr lst		lstree 3
abbr t			broot


#-- Common --#

abbr l1			lstree 1
abbr l2			lstree 2
abbr l3			lstree 3
abbr l4			lstree 4
abbr l5			lstree 5






