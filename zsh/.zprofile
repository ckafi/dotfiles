# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty7" ]; then
	exec sway &> .sway.log
fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
