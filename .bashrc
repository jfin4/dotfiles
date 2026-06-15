#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# check tty
this_tty=$(tty | sed -e 's#/dev/##')
typeset -A expected_ttys=(
    [karen]="3"
    [basilia]="4"
    [ginny]="5"
)
target_tty="${expected_ttys[$USER]}"
if [[ -z "$DISPLAY" && "$this_tty" != "tty$target_tty" ]]; then
    for i in {1..50}; do
        echo -ne "\r==> GO TO F$target_tty <=="
        sleep 0.2
        echo -ne "\r    GO TO F$target_tty    "
        sleep 0.2
    done
    exit
fi

# startx
if [[ -z "$DISPLAY" ]]; then
    exec startx
fi
