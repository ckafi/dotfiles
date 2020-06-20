PATH=$HOME/bin:$PATH

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty7" ]; then
  exec sway &> ~/.sway.log
fi
