# options
shopt -s direxpand
shopt -s cdable_vars

# https://wiki.archlinux.org/title/Bash# options
# To remove all but the last identical command, and commands that start with a space:
export HISTCONTROL="erasedups:ignorespace"

# complete some commands
source $HOME/src/bash_completion

# set up fzf
eval "$(fzf --bash)"
# rebind readline commands, i only use ** trigger
bind '"\C-t": transpose-chars'
bind '"\C-r": reverse-search-history'
bind '"\M-c": capitalize-word'

# prompt
export PS1='\[\033]0;${PWD##*/}\007\]\n\w`__git_ps1`\n$ '

# ensure cursor blinks in vim terminals
echo -e "\e[?12h"

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/scripts:$PATH" 
PATH="$HOME/bin:$PATH" 
PATH="$HOME/AppData/Roaming/Python/Python312/Scripts:$PATH"
# get latest r
for r in "c:/Program Files/R"/*; do
    true
done
PATH="/c${r#c:}/bin/x64:$PATH" 
export PATH

# shortcut variables
export bbp='/c/users/jinman/onedrive - water boards/projects/'
export bbr='/c/users/jinman/desktop/final_relep/'
export dd=$(date +%Y-%m-%d)

# aliases 

alias aws_ssh='ssh -i /home/JInman/.ssh/LightsailDefaultKey-us-west-2.pem admin@54.148.13.14'
alias bak='back-up-file'
alias cp='cp --recursive --no-clobber'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias lf='lf -config ~/.config/lf/lfrc'
alias ll='ls -l --time-style=long-iso --classify --human-readable'
alias ls='ls --format=single-column --classify'
alias mvv='rename-files'
alias notes='cd ~/notes; search-files "" notes.txt; cd -'
alias todo='cd ~/notes; search-files "#todo" notes.txt; cd -'
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias pw='get-password'
alias rm='~/scripts/move-to-trash'
alias sob='source ~/.bashrc'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias open='open-link'

# future ideas
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
