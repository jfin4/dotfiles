# options{{{

# https://wiki.archlinux.org/title/Readline#Faster_completion
# https://www.man7.org/linux/man-pages/man3/readline.3.html

bind '"\C-@": glob-expand-word'
bind '"\e[Z": menu-complete'
bind '"\t": menu-complete-backward'
bind 'set bell-style none'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'
shopt -s direxpand
shopt -s nocaseglob

# if interactive then make cursor blink
[[ $- == *i* ]] && echo -e "\e[?12h"

# }}}
# variables{{{

export EDITOR=vim
export BROWSER=lynx
export LYNX_CFG=$HOME/.lynx/lynx.cfg
export LYNX_LSS=$HOME/.lynx/lynx.lss
export VIMINIT=':source $HOME/.vim/vimrc'

# https://wiki.archlinux.org/title/Bash# options
# To remove all but the last identical command, and commands that start with a space:
export HISTCONTROL="erasedups:ignorespace"

# for mobaxterm
[[ $HOSTNAME == WB-102575 ]] && export DISPLAY="localhost:0.0"

# shortcuts
export date=$(date +%Y-%m-%d)
if [[ $HOSTNAME == WB-102575 ]]; then
    export bo='/c/users/jinman/onedrive - water boards'
    export br='/c/users/jinman/desktop/final_relep'
   
    # hosts substitute
    export arch='jfin@10.0.0.52'
    export rpi='jfin@10.0.0.159'
fi
# }}}
# completion{{{

[[ $HOSTNAME == WB-102575 ]] && source $HOME/.bash_completion
complete -cf doas

# }}}
# prompt{{{

[[ $HOSTNAME == jfin ]] && source /usr/share/git/completion/git-prompt.sh
[[ $HOSTNAME == rpi ]] && source ~/scripts/git-prompt.sh
[[ $HOSTNAME == t14 ]] && source /usr/share/git/git-prompt.sh

PS1="\[\e]0;\h \W\a\]"; # set title
PS1="$PS1"'\n'; # blank line after previous command
PS1="$PS1"'\[\e[37m\]'; # start color
PS1="$PS1"'\h \w'; # working dir
PS1="$PS1"'`__git_ps1 " %s"`'; # git info
PS1="$PS1"'\n'; # start second line
PS1="$PS1""${TMUX:+t}"; # tmux?
PS1="$PS1"'\$ '; # end with $
PS1="$PS1"'\[\e[0m\]'; # end color

# }}}
# path{{{

[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$initial_path"
PATH="$HOME/scripts:$PATH" 
PATH="$HOME/.bin:$PATH" 
PATH="$HOME/.local/bin:$PATH" 
if [[ $HOSTNAME == 'WB-102575' ]]; then
    PATH="$HOME/AppData/Roaming/Python/Python312/Scripts:$PATH"
    # get latest r
    for r in "c:/Program Files/R"/*; do
        true
    done
    PATH="/c${r#c:}/bin/x64:$PATH" 
fi
export PATH
# }}}
# fzf{{{

# https://github.com/junegunn/fzf?tab=readme-ov-file
eval "$(fzf --bash)"
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
# }}}
# aliases {{{

alias aws_ssh='ssh -i /home/JInman/.ssh/LightsailDefaultKey-us-west-2.pem admin@54.148.13.14'
alias bak='back-up-file'
alias cp='cp --recursive --no-clobber'
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias kb='show-key-bindings'
alias la='ls -AlhF'
alias lf='lf -config ~/.config/lf/lfrc'
alias ll='ls -l --time-style=long-iso --classify --human-readable'
alias ls='ls -1p'
alias mutt='neomutt'
alias mvv='rename-files'
alias notes='cd ~/notes; search-notes notes.txt; cd -'
alias todo='cd ~/notes; search-notes "#todo"; cd -'
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias sob='source ~/.bashrc'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias open='open-link'
alias gits='git status'
alias dots='dot status'
alias gitp='git pull'
alias dotp='dot pull'
alias sshr='ssh -p 2222 jfin@10.0.0.160'
alias ssht='ssh jfin@10.0.0.27'
alias sshtx='ssh -YC jfin@10.0.0.27'
alias start='\start ""'
if [[ $HOSTNAME == t14 ]]; then
    alias ai="aider \
        --model openrouter/deepseek/deepseek-chat \
        --api-key openrouter=$(< ~/.pass/openrouter-api-key) \
        --no-pretty \
        --watch-files"
fi
# }}}
# functions
# fuzzy cd{{{
function cd() {
    dir=${1:-~}
    if ! command cd "$dir" 2> /dev/null; then
        glob=""
        for (( i=0; i<${#dir}; i++ )); do
            char="${dir:i:1}"
            glob+="*-${char}"
        done
        glob+="*"
        command cd $glob
    fi
}
# }}}
# git add commit push{{{
gitt() { 
    git add .
    git commit -m "${*:-no message}"
    git push
}
# }}}
# dot add commit push{{{
dott() { 
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME add -u
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME commit -m "${*:-no message}"
    git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME push
}
# }}}
# send to trash{{{
rm() { 
    mv --backup=numbered "$@" ~/.trash
}
# }}}
# get password{{{
pw() {
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
# }}}
# generate password{{{
generate_password() {
    # Reset OPTIND since we're in a function
    local OPTIND=1

    # Set defaults
    local length=20
    local symbols="!\"#$%&'()*+,-./:;<=>?@[\]^_\`{|}~"

    # Parse arguments using getopts
    while getopts "hl:s:" opt; do
        case $opt in
            h)
                echo "Options"
                echo "    -l NUM         password length"
                echo "    -s SYMBOLS     acceptable symbols, e.g., '!@#$'"
                return 0
                ;;
            l)
                # Ensure length is treated as a number
                length=$(( OPTARG + 0 ))
                ;;
            s)
                symbols="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                return 1
                ;;
        esac
    done

    # Generate password
    local chars="$(echo {a..z} {A..Z} {0..9} | tr -d ' ')$symbols"
    tr -dc "$chars" < /dev/urandom | head -c "$length"
    echo
}
# }}}
# magic expand{{{
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
declare -A abbreviations=(
  ["copy"]="> /dev/clipboard"
)

expand-abbrev() {
  local abbrev_key replacement new_line new_pos
  # Extract the part of the line before the cursor
  local line_up_to_cursor="${READLINE_LINE:0:$READLINE_POINT}"
  # Check if the line ends with a potential abbreviation
  if [[ "$line_up_to_cursor" =~ ([_a-zA-Z0-9]+)$ ]]; then
    abbrev_key="${BASH_REMATCH[1]}"
    if [[ -v abbreviations["$abbrev_key"] ]]; then
      # Get the replacement value
      replacement="${abbreviations[$abbrev_key]}"
      # Construct the new line
      new_line="${line_up_to_cursor%$abbrev_key}$replacement ${READLINE_LINE:$READLINE_POINT}"
      READLINE_LINE="$new_line"
      # Calculate new cursor position
      # new_pos=$(( READLINE_POINT - ${#abbrev_key} + ${#replacement} + 1 ))
      new_pos=$(( READLINE_POINT - ${#abbrev_key} + ${#replacement} ))
      READLINE_POINT="$new_pos"
      return
    fi
  fi
  # If no expansion, insert space normally
  READLINE_LINE="${READLINE_LINE:0:READLINE_POINT} ${READLINE_LINE:$READLINE_POINT}"
  # READLINE_POINT=$(( READLINE_POINT + 1 ))
}

# Bind SPACE to magic expand
bind -x '"\C-@":expand-abbrev'
# }}}

if [[ $HOSTNAME == rpi ]]; then
    alias ll='ls -lFh'
    rm() { 
        mv "$@" ~/.trash
    }
fi
