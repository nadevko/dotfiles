# man 1 bash
set -a

BASH_RC=~/.Env/shell/rc.bash
BASH_ENV=~/.Env/shell/env.bash
HOSTFILE=/etc/hosts

source ~/.config/user-dirs.dirs
PATH="$HOME/Assets/bin:$PATH"

HISTCONTROL=ignorespace:erasedups
HISTFILESIZE=$(( 32 ** 4 ))
HISTSIZE=$(( 32 ** 3 ))
HISTTIMEFORMAT='%Y-%m-%dT%H:%M:%S%z '

SSH_AUTH_SOCK=~/.Volatile/ssh-agent.sock
DBUS_SESSION_BUS_ADDRESS="unix:path=$HOME/.Volatile/dbus"
set +a

[[ $- == *i* ]] && source "$BASH_RC"
[[ $(tty) == /dev/tty1 ]] && exec dbus-run-session niri --session
