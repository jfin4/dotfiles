# options
shopt -s direxpand
shopt -s nocaseglob

# https://wiki.archlinux.org/title/Bash# options
# To remove all but the last identical command, and commands that start with a space:
export HISTCONTROL="erasedups:ignorespace"

# for vcxsrv
export DISPLAY="localhost:0.0"

# complete some commands
[[ $(hostname) == 'WB-102575' ]] && source $HOME/.bash_completion

# prompt
[[ $(hostname) == 'jfin' ]] && source /usr/share/git/completion/git-prompt.sh
x='${SSH_TTY:+\u@\h }'
# $(command) doesn't work on windows, use `command`
PS1="\[\e]0;$x\W\a\]\n$x\w\`__git_ps1 ' %s'\`\n\$ "

# if interactive then make cursor blink
[[ $- == *i* ]] && echo -e "\e[?12h"

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/scripts:$PATH" 
if [[ $(hostname) == 'WB-102575' ]]; then
    PATH="$HOME/.bin:$PATH" 
    PATH="$HOME/AppData/Roaming/Python/Python312/Scripts:$PATH"
    # get latest r
    for r in "c:/Program Files/R"/*; do
        true
    done
    PATH="/c${r#c:}/bin/x64:$PATH" 
fi
export PATH

# set up fzf
if [[ $(hostname) == 'rpi' ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
else
    eval "$(fzf --bash)"
fi
# rebind readline commands, i only use .. trigger
bind '"\C-t": transpose-chars'
bind '"\C-r": reverse-search-history'
bind '"\ec": capitalize-word'
# trigger sequence
export FZF_COMPLETION_TRIGGER='ii'
# use fd 
_fzf_compgen_path() {
    fd --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
    fd --type d --follow --exclude ".git" . "$1"
}

# shortcut variables
export bo='/c/users/jinman/onedrive - water boards'
export br='/c/users/jinman/desktop/final_relep'
export dd=$(date +%Y-%m-%d)

# hosts substitute
export arch='jfin@10.0.0.52:/home/jfin'
export rpi='jfin@10.0.0.158:/home/jfin'

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
alias notes='cd ~/notes; search-notes notes.txt; cd -'
alias todo='cd ~/notes; search-notes "#todo"; cd -'
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias pw='get-password'
alias rm='~/scripts/move-to-trash'
alias sob='source ~/.bashrc'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias open='open-link'
alias ai="aider --model openrouter/deepseek/deepseek-chat --api-key openrouter=$(< ~/.pass/openrouter-api-key) --watch-files"
alias start='\start ""'
alias sshj='ssh -YC jfin@10.0.0.52'
alias sshr='ssh -YC jfin@10.0.0.158'
alias gits='git status'
alias dots='dot status'
alias gitp='git pull'
alias dotp='dot pull'

gitt() {
    git add .
    git commit -m "${*:-no message}"
    git push
}

dott() {
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME add -u
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME commit -m "${*:-no message}"
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME push
}

# expand command line
expand_line() {
  local expanded_line=""
  local token
  for token in $READLINE_LINE; do
    local expanded=$(eval "echo $token")
    expanded_line+="$(printf '%q' "$expanded") " # space at end separates tokens
  done
  READLINE_LINE="${expanded_line% }" # remove last space?
  READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-l\C-l": expand_line'

# future ideas
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
# this replaces dots with stars for easier globbing, like zsh partial string
# expansion
# READLINE_LINE="${READLINE_LINE//./*}"
