if not status is-interactive
    exit
end

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
abbr c            clear_screen
abbr q            exit
abbr rbt          reboot
abbr po           poweroff

abbr n            nvim
abbr nv           neovide 

abbr zl           'zellij'
abbr za           'zellij a'
abbr zn           'zellij -s'

abbr m            make
abbr mr           make run
abbr ca           cargo
abbr cr           cargo run --
abbr ct           cargo test --all
abbr zr           zig build run --
abbr nr           nimble run --
abbr or           odin run .

### Pacman ###
abbr get          'sudo pacman -S'
abbr upd          'sudo pacman -Syyu --noconfirm'
abbr rem          'sudo pacman -Rns'

### Git ###
abbr g                      git
abbr go                     git checkout
abbr ga                     git add
abbr --set-cursor   gm      'git commit -m "%"'
abbr --set-cursor   gam     'git commit -am "%"'
abbr gp                     git push
abbr gpu                    git pull
abbr gf                     git fetch
abbr gs                     git status
abbr gst                    git stash
abbr gd                     git diff

function set-git-id
	if test (count $argv) -ne 2
		echo "usage: $1 <username> <email>"
	end

	git config user.name $argv[1]
	git config user.email $argv[2]
end

abbr gl                     git logtree
abbr gls                    git logtree
abbr glo                    git log

### Fish ###
abbr fn           'funced -e nvim -s'

function last_history_item
	echo $history[1]
end
abbr !! --position anywhere --function last_history_item
abbr -p=anywhere --set-cursor mm '~/%'


### Remind (and force) me to use the good (and rusty) tools ###
#abbr grep        rg
#abbr find        fd
#abbr less        most
#abbr sed         sd
#abbr htop        ytop
#abbr du          dust
#abbr ncdu        dust
#abbr man         tldr
# alias z         zoxide
abbr cd           z
abbr dust         'br -w'
abbr cat          bat



### ls or tree ###

# Make eza show icons by default
alias eza 'eza --icons'

function lstree
	if test (count $argv) = 0
		eza -TL 1 2> /dev/null
		or tree -CL 1 2> /dev/null
		or ls -l
	else
		eza -TL $argv 2> /dev/null
		or eza -TL 1 $argv

		or tree -CL $argv 2> /dev/null
		or tree -CL 1 $argv

		or ls -l $argv
	end
end


#-- List version --#

# abbr l            'eza'
# abbr ls           'eza -l'
# abbr la           'eza -la'
# abbr lst          lstree
# abbr t            lstree


#-- Tree version --#

abbr l            lstree
abbr la           lstree 1 -la
abbr lst          lstree 3
abbr t            broot


#-- Common --#

abbr l1           lstree 1
abbr l2           lstree 2
abbr l3           lstree 3
abbr l4           lstree 4
abbr l5           lstree 5


alias copy="xclip -selection clipboard"



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

function quick-scripts
   lstree ~/config/scripts/
end


