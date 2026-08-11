
[parallel]
check-all: check-broot check-dwm check-leftwm

check-broot:
   just div/broot/check

check-dwm:
   just window_managers/config_builder/check-dwm

check-leftwm:
   just window_managers/config_builder/check-leftwm

install-all: install-git

install-git:
   cp ./div/gitconfig ~/.gitconfig

