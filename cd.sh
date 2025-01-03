#!/bin/bash
# c is a user-friendly replacement to cd
# NOTE: Depends on zoxide, fzf, and eza
# NOTE: While in the fzf menu, dereferenced directories will not show their contents within the side view. Limited by eza's capabilities.

c(){
	if [[ -z $1 || $1 == "cont" ]]; then
		# displays items from eza to fzf with a preview of their directory tree -- includes color
    # the -X flag is required for --show-symlinks. If it's just --show-symlinks, it'll be in an unacceptable format, rendering it unusable. -X dereferences the symlink to the appropriate format.
		directory=$(eza -a -a --reverse --no-quotes --color=always --only-dirs --show-symlinks -X| fzf --ansi --preview "eza --tree --color=always --level=3 -a --no-quotes --show-symlinks -X {}")

		# if something was selected, cd into it and go do c again
		if [[ -n $directory ]]; then
			z $directory
			c "cont"
		# if nothing selected, exit
		else
			return
		fi

	else
		echo "No recursion"
		z $1
	fi
}
