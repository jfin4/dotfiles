#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dotp='dot pull'
alias dots='dot status'
alias dott='add-commit-push-dotfiles'

PS1='[\u@\h \W]\$ '

# test if already logged in
this_term=$(tty | sed -e 's#/dev/##')
all_terms=$(who | grep $USER | awk '{print $2}')
for term in $all_terms; do
    if [[ -z "$DISPLAY" && $term != $this_term ]]; then
        term_no=$(echo $term | grep -o -e '[0-9]')
        echo -e "\nALREADY LOGGED IN\n" 
        for i in {1..50}; do
            echo -ne "\r==> GO TO F${term_no} <=="
            sleep 0.2
            echo -ne "\r    GO TO F${term_no}    "
            sleep 0.2
        done
        exit
    fi
done

# startx
if [[ -z "$DISPLAY" ]]; then
    exec startx
fi
