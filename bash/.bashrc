
export config_dir="$HOME/config"

### First load variables ###
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

export VISUAL="neovide"
export EDITOR="nvim"
export PAGER="nvim"

default_filemanager="thunar"
default_imageviewer="feh"
default_pdfviewer="zathura"
default_video_player="vlc"

### Source config files ###

# Aliases
if [ -f "$config_dir/bash/aliases.bash" ]; then
	source "$config_dir/bash/aliases.bash"
fi

# Prompt (PS1, PS2, PS4)
if [ -f "$config_dir/bash/prompt.bash" ]; then
	source "$config_dir/bash/prompt.bash"
fi

# Functions (ex, open)
if [ -f "$config_dir/bash/functions.bash" ]; then
	source "$config_dir/bash/functions.bash"
fi

# Completion (**[Tab] --> fzf)
if [ -f "$config_dir/bash/completion.bash" ]; then
	source "$config_dir/bash/completion.bash"
fi

# Key bindings (<C-r> --> fzf history, <C-t> --> fzf)
if [ -f "$config_dir/bash/key-bindings.bash" ]; then
	source "$config_dir/bash/key-bindings.bash"
fi
