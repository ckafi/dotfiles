PATH=$HOME/.local/bin:$PATH
PATH=$HOME/.cargo/bin:$PATH
PATH=$HOME/.nimble/bin:$PATH
PATH=$HOME/.local/share/ponyup/bin:$PATH
PATH=$HOME/bin:$PATH

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty7" ]; then
  exec systemd-cat --identifier=sway sway
fi
