#!/bin/sh
echo "Note: should be executed from the same directory as the config scripts"
echo "Note: autorandr should be installed"
echo "Note: May need to run this file as root (for chmod +x)"

file_names=("laptop" "ext_default" "extern_uwhd")

for file_name in "${file_names[@]}"; do
	chmod +x "$file_name.sh"
	ln -s $file_name.sh $HOME/.config/autorandr/$file_name/postswitch
	echo "Created $HOME/.config/autorandr/$file_name/postswitch"
done

echo "Done"
