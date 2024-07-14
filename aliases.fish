
# Dependencies:
# `exa ripgrep fd dust zoxide`
#
# Optional:
# `most ytop tealdeer`



### Terminal ###
function clear_screen
	clear && echo
end

# Terminal itself
abbr c         clear_screen
abbr q         exit
abbr rbt       reboot
abbr po        poweroff

abbr n         nvim .
abbr nv        neovide .

abbr zl        'zellij -l'
abbr za        'zellij a'
abbr zn        'zellij -s'

abbr mr        make run
abbr cr        cargo run --

### Pacman ###
abbr get       'sudo pacman -S'
abbr up        'sudo pacman -Syyu --noconfirm'
abbr rem       'sudo pacman -Rns'

### Git ###
abbr g         git
abbr go        git checkout
abbr ga        git add
abbr --set-cursor   gm      'git commit -m "%"'
abbr gp        'tok_gt && git push'
abbr gs        git status

### Fish ###
abbr fn        'funced -e nvim -s'

function last_history_item
    echo $history[1]
end
abbr !! --position anywhere --function last_history_item
abbr -p=anywhere --set-cursor mm '~/%'


### Remind (and force) me to use the good (and rusty) tools ###
#abbr grep     rg
#abbr find     fd
#abbr less     most
#abbr sed      sd
#abbr htop     ytop
#abbr du       dust
#abbr ncdu     dust
#abbr man      tldr
#abbr cd        z # zoxide (source zoxide config)

# - broot
# - foot (terminal emulator)


### ls or tree ###

# Make exa show icons by default
alias exa 'exa --icons'

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

abbr l         'exa'
abbr ls        'exa -l'
abbr la        'exa -la'
abbr lst       lstree
abbr t         lstree


#-- Tree version --#

abbr l         lstree
abbr ls        lstree 2
abbr la        lstree 1 -la
abbr lst       lstree 3
abbr t         broot


#-- Common --#

abbr l1        lstree 1
abbr l2        lstree 2
abbr l3        lstree 3
abbr l4        lstree 4
abbr l5        lstree 5





#-- Functions --#


# Decimal to binary
function d2b
	if test (count $argv) -ne 1
		echo "Usage: d2b <number>"
	end
	if test $argv[1] -gt 255
		echo "Can only convert one byte"
	end

	set -l n $argv[1]
	set -l res
	for i in (seq 7 -1 0)
		if test 0 -eq (math bitand $n, 2^$i)
			set -a res 0
		else
			set -a res 1
		end
	end
	echo $res
end


