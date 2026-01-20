use str

# Bindings
set edit:insert:binding[Ctrl-l] = { clear > /dev/tty; edit:redraw &full=$true }
set edit:completion:binding[Ctrl-w] = { edit:close-mode; edit:kill-word-left }

set edit:insert:binding[Alt-l] = { edit:location:start }

set edit:abbr['get '] = 'sudo pacman -S '
set edit:abbr['up '] = 'sudo pacman -Syyu --noconfirm '

set edit:abbr['ga '] = 'git add '
set edit:abbr['gs '] = 'git status '
set edit:abbr['go '] = 'git checkout '
set edit:abbr['gm '] = "git commit -m ''"

set edit:abbr['c '] = 'clear '

var n~ = { nvim }

fn down {
}

# Setup
fn add_path { |path|
   set E:PATH = (str:join ':' [$E:PATH $path])
}
add_path $E:HOME/.cargo/bin
add_path $E:HOME/.ghcup/bin
add_path $E:HOME/.nimble/bin

eval (zoxide init elvish | slurp)



