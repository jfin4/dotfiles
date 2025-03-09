# prompt
export PS1='\[\033]0;$PWD\007\]\n\w`__git_ps1`\n$ '

# Use bash-completion, if available
source $HOME/src/bash_completion

# https://wiki.archlinux.org/title/Bash# options
# To remove all but the last identical command, and commands that start with a space:
export HISTCONTROL="erasedups:ignorespace"

# shortcut variables
export dd=$(date +%Y-%m-%d)
export mm='mingw-w64-ucrt-x86_64-'
export bba='c:/users/jinman/appdata/local/'
export bbd='c:/users/jinman/downloads/'
export bbo='c:/users/jinman/onedrive - water boards/'
export bbp='c:/users/jinman/onedrive - water boards/projects/'
export bbr='c:/users/jinman/desktop/final_relep/'
export bbu='c:/users/jinman/'

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

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

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
