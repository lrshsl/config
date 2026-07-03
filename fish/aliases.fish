if not status is-interactive
    exit
end

# Dependencies:
# `eza zoxide neovim`
#
# Optional:
# `tealdeer xclip rg fd git just make cargo zellij jujutsu`


# Terminal itself
abbr po           poweroff

abbr n            nvim

abbr zl           'zellij'
abbr za           'zellij a'
abbr zn           'zellij -s'

# Build & run
abbr r            just run
abbr rt           just test
abbr rb           just build
abbr m            make
abbr mr           make run
abbr ca           cargo
abbr cr           cargo run --

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
abbr gf                     git fetch --all
abbr gs                     git status
abbr gst                    git stash
abbr gd                     git diff
abbr gl                     git logtree

abbr nn                     jj

function set-git-id
	if test (count $argv) -ne 2
		echo "usage: $1 <username> <email>"
	end

	git config user.name $argv[1]
	git config user.email $argv[2]
end

### Fish ###
abbr fn           'funced -e nvim -s'

function last_history_item
	echo $history[1]
end
abbr !! --position anywhere --function last_history_item
abbr -p=anywhere --set-cursor mm '~/%'


### Tools
#abbr grep        rg
#abbr find        fd
#abbr less        most
#abbr sed         sd
#abbr htop        ytop
#abbr du          dust
#abbr ncdu        dust
#abbr dust         'br -w'
#abbr man         tldr
# alias z         zoxide
abbr cd           z
abbr cat          bat

abbr rg           'rg -.'
abbr fd           'fd -H'

abbr rga          'rg -. --no-ignore'
abbr fda          'fd -H --no-ignore'


### ls or tree ###

# Make eza show icons by default
alias eza 'eza --icons'

function lstree
   set -l usage 'lstree [LEVEL] [PATH..]'
	if test (count $argv) = 0
		eza -TL 1 2> /dev/null
		or tree -CL 1 2> /dev/null
		or ls -l
      or echo 'No ls?!'
	else
      # $1 : directory or ''
      if test -d $argv[1] -o -z $argv[1]
         eza -TL 1 $argv
         or tree -CL 1 $argv
         or ls -l $argv

         or echo $usage

      # $1 : file
      elif test -f $argv[1]
         bat $argv
         or cat $argv

      # $1 : number
      else
         eza -TL $argv
         or tree -CL $argv
         or ls -l $argv

         or echo $usage
      end
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


