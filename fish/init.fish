if not status is-interactive
    exit
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.nimble/bin
fish_add_path $HOME/.nix-profile/bin
fish_add_path /usr/lib/jvm/default/bin/

zoxide init fish | source

#echo -e '\033[?17;0;120c' # White block cursor for tty
#setfont ter-u18n.psf.gz
