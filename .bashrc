# options
shopt -s direxpand
shopt -s nocaseglob

# https://wiki.archlinux.org/title/Bash# options
# To remove all but the last identical command, and commands that start with a space:
export HISTCONTROL="erasedups:ignorespace"

# for mobaxterm
[[ $HOSTNAME == WB-102575 ]] && export DISPLAY="localhost:0.0"

# complete some commands
[[ $HOSTNAME == WB-102575 ]] && source $HOME/.bash_completion

# prompt
[[ $HOSTNAME == jfin ]] && source /usr/share/git/completion/git-prompt.sh
# $(__git_ps1) doesn't work on windows, use `__git_ps1`

PS1="\[\e]0;${SSH_TTY:+\h }\W\a\]" # set title
PS1="$PS1"'\n' # blank line after previous command
PS1="$PS1"'\[\e[37m\]' # start color
PS1="$PS1""${SSH_TTY:+\h }" # host info if ssh'ing
PS1="$PS1"'\w' # working dir
PS1="$PS1"'`__git_ps1 " %s"`' # git info
PS1="$PS1"'\n' # start second line
PS1="$PS1""${TMUX:+tmux }" # signify tmux
PS1="$PS1"'\$ ' # end with $
PS1="$PS1"'\[\e[0m\]' # end color

# if interactive then make cursor blink
[[ $- == *i* ]] && echo -e "\e[?12h"

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/scripts:$PATH" 
if [[ $HOSTNAME == 'WB-102575' ]]; then
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
# https://github.com/junegunn/fzf?tab=readme-ov-file
if [[ $HOSTNAME == 'rpi' ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
else
    eval "$(fzf --bash)"
fi
# rebind readline commands, i only use .. trigger
bind '"\C-t": transpose-chars'
bind '"\C-r": reverse-search-history'
bind '"\ec": capitalize-word'

# Use trigger sequence other than the default **
export FZF_COMPLETION_TRIGGER='ii'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# shortcut variables
export dd=$(date +%Y-%m-%d)
if [[ $HOSTNAME == WB-102575 ]]; then
    export bo='/c/users/jinman/onedrive - water boards'
    export br='/c/users/jinman/desktop/final_relep'
   
    # hosts substitute
    export arch='jfin@10.0.0.52:/home/jfin'
    export rpi='jfin@10.0.0.158:/home/jfin'
fi

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
alias sob='source ~/.bashrc'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias open='open-link'
alias ai="aider \
    --model openrouter/deepseek/deepseek-chat \
    --api-key openrouter=$(< ~/.pass/openrouter-api-key) \
    --no-pretty \
    --multiline \
    --watch-files"
alias gits='git status'
alias dots='dot status'
alias gitp='git pull'
alias dotp='dot pull'
if [[ $HOSTNAME == rpi ]]; then
    alias fd='fdfind'
elif [[ $HOSTNAME == WB-102575 ]]; then
    alias sshj='ssh -YC jfin@10.0.0.52'
    alias sshr='ssh -YC jfin@10.0.0.158'
    alias start='\start ""'
fi

# functions

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

rm() {
    if [[ $HOSTNAME == rpi ]]; then
        mv --backup=numbered "$@" /media/jfin/ssd/.trash
    else
        mv --backup=numbered "$@" ~/.trash
    fi
}

pass() {
    cd $HOME/.pass
    account=$(\
        fd --path-separator // ${*:-.} |\
        fzf \
        --height 40% --reverse \
        --preview 'cat {}' 
    )
    password=$(head -n1 $account)
    if [[ $password ]]; then
        old_clipboard=$(< /dev/clipboard)
        echo -n "$password" > /dev/clipboard
        (
        { sleep 10
            echo -n "$old_clipboard" > /dev/clipboard
        } &
    )
    fi
    cd - > /dev/null
}

# future ideas
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
# this replaces dots with stars for easier globbing, like zsh partial string
# expansion
# READLINE_LINE="${READLINE_LINE//./*}"
