# Functions
# ex() --> extract
# open() --> open a file

# Extract (inspiration from arcolinux)
# - Extract archives
# - Usage: ex <file>

ex() {
	[[ -f $1 ]] || {
		echo "'$1' is not a valid file"
		return 1
	}
	case $1 in
		*.tar.bz2)   tar xjf $1		;;
		*.tar.gz)    tar xzf $1		;;
		*.bz2)       bunzip2 $1		;;
		*.rar)       unrar x $1		;;
		*.gz)        gunzip $1		;;
		*.tar)       tar xf $1		;;
		*.tbz2)      tar xjf $1		;;
		*.tgz)       tar xzf $1		;;
		*.zip)       unzip $1		;;
		*.Z)         uncompress $1	;;
		*.7z)        7z x $1			;;
		*)           echo "'$1' cannot be extracted via ex()" ;;
	esac
}

open() {
	[[ -f $1 ]] || {
		echo "'$1' is not a valid file"
		return 1
	}
	[[ -d $1 ]] && {
		$app_filemanager $1
	}
	case $1 in
		*.pdf)       $default_pdfviewer $1		;;
		*.png|*.jpg) $default_imageviewer $1	;;
		*.mp4)       $default_video_player $1	;;
		*)           $EDITOR $1						;;
	esac
}
