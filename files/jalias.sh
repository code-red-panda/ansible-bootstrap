#########################
### vim
#########################

if test -e $(which vim)
then
    alias vi="$(which vim)"
fi

#########################
### Prompt Styling
#########################

if test $(whoami) = 'root'
then
    COLOR_USER="\[\033[1;37;45m\]" # Highlight purple
else
    COLOR_USER="\[\033[1;35m\]" # Highlight red
fi

RESET="\[\033[0m\]"
COLOR_DATE="\[\033[0;36m\]"
COLOR_HOSTNAME="\[\033[1;31m\]"
COLOR_DIR="\[\033[0;33m\]"

export PS1="[${COLOR_DATE} \d \t UTC ${RESET}] ${COLOR_USER}\u${RESET}@${COLOR_HOSTNAME}${HOSTNAME}${RESET} ${COLOR_DIR}\w${RESET} \n# "
export PS2="> "
