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
    export rpi='jfin@10.0.0.158'
fi
# }}}
# completion{{{

[[ $HOSTNAME == WB-102575 ]] && source $HOME/.bash_completion

# }}}
# prompt{{{

[[ $HOSTNAME == jfin ]] && source /usr/share/git/completion/git-prompt.sh
[[ $HOSTNAME == rpi ]] && source /usr/lib/git-core/git-sh-prompt

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

[[ $HOSTNAME == rpi ]] && source ~/.cargo/env

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
alias ls='ls --format=single-column --classify'
alias mutt='neomutt'
alias mvv='rename-files'
alias notes='cd ~/notes; search-notes notes.txt; cd -'
alias todo='cd ~/notes; search-notes "#todo"; cd -'
alias pdf='open-pdf'
alias prod='echo; Rscript ~/scripts/get-productivity.r' 
alias sob='source ~/.bashrc'
alias vdk='pdf ~/.visidata-cheat-sheet.pdf'
alias open='open-link'
alias ai="aider \
    --model openrouter/deepseek/deepseek-chat \
    --api-key openrouter=$(< ~/.pass/openrouter-api-key) \
    --no-pretty \
    --watch-files"
alias gits='git status'
alias dots='dot status'
alias gitp='git pull'
alias dotp='dot pull'
if [[ $HOSTNAME == rpi ]]; then
    alias fd='fdfind'
    alias vim='vim -X' # connecting to X server is slow
elif [[ $HOSTNAME == WB-102575 ]]; then
    alias sshj='ssh -YC jfin@10.0.0.52'
    alias sshr='ssh -YC jfin@10.0.0.158'
    alias start='\start ""'
fi
# }}}
# functions{{{
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
    if [[ $HOSTNAME == rpi ]]; then
        mv --backup=numbered "$@" /media/jfin/ssd/.trash
    else
        mv --backup=numbered "$@" ~/.trash
    fi
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
# }}}
# future ideas{{{
# https://web.archive.org/web/20180329223229/http://zshwiki.org:80/home/examples/zleiab
# this replaces dots with stars for easier globbing, like zsh partial string
# expansion
# READLINE_LINE="${READLINE_LINE//./*}"
# }}}
# misc{{{

# if interactive then make cursor blink
[[ $- == *i* ]] && echo -e "\e[?12h"

# }}}
# __make_fuzzy() { # uses sed{{{
#     local _FUZZY_SEPARATORS="/-_"
#     local line="$READLINE_LINE"
#     local cmd args_str
#     if [[ "$line" =~ ^([^[:space:]]+)[[:space:]]+(.*) ]]; then
#         cmd="${BASH_REMATCH[1]}"; args_str="${BASH_REMATCH[2]}"
#     elif [[ "$line" =~ ^([^[:space:]]+)$ ]]; then
#         cmd="$line"; args_str=""; return 0
#     else
#         return 0
#     fi
#     [[ -z "$args_str" ]] && return 0

#     local fuzzy_args_final="" arg fuzzy_single_arg
#     local original_ifs="$IFS"; IFS=$' \t\n'

#     for arg in $args_str; do
#         if [[ -z "$arg" ]]; then
#             fuzzy_single_arg=""
#         else
#             # Step 1: General fuzzy logic
#             fuzzy_single_arg=$(sed "s#[^${_FUZZY_SEPARATORS}]\+#*&*#g" <<< "$arg")
#             # Step 2: Correct '*..*' back to '..' (robust escaping)
#             fuzzy_single_arg=$(sed 's#\*\.\.\*#..#g' <<< "$fuzzy_single_arg")
#         fi

#         if [[ -n "$fuzzy_single_arg" ]]; then
#              fuzzy_args_final+=" $fuzzy_single_arg"
#         elif [[ -n "$arg" ]]; then
#              fuzzy_args_final+=" $arg"
#         fi
#     done

#     IFS="$original_ifs"
#     fuzzy_args_final="${fuzzy_args_final# }"
#     if [[ -n "$fuzzy_args_final" ]]; then
#         READLINE_LINE="$cmd $fuzzy_args_final"
#         READLINE_POINT=${#READLINE_LINE}
#     fi
# }
# bind -x '"\C-l\C-l":__make_fuzzy'
# bind '"\C-l":clear-screen'
# }}}
# __make_fuzzy() { # bash only, faster on windows{{{
#     # --- Configuration ---
#     local _FUZZY_SEPARATORS="/-_." # Add/remove separators as needed

#     # --- Readline Interaction ---
#     local line="$READLINE_LINE"

#     # --- Command/Argument Parsing ---
#     local cmd args_str
#     if [[ "$line" =~ ^([^[:space:]]+)[[:space:]]+(.*) ]]; then
#         cmd="${BASH_REMATCH[1]}"; args_str="${BASH_REMATCH[2]}"
#     elif [[ "$line" =~ ^([^[:space:]]+)$ ]]; then
#         cmd="$line"; args_str=""; return 0
#     else
#         return 0
#     fi
#     [[ -z "$args_str" ]] && return 0

#     # --- Argument Processing ---
#     local fuzzy_args_final=""
#     local arg fuzzy_single_arg
#     local original_ifs="$IFS"; IFS=$' \t\n'

#     for arg in $args_str; do
#         # --- BEGIN INLINED PURE BASH FUZZY LOGIC ---
#         fuzzy_single_arg="" # Initialize result for this argument
#         if [[ -n "$arg" ]]; then
#             local current_part=""
#             local i char is_separator=0
#             local arg_len=${#arg}

#             for (( i=0; i<arg_len; i++ )); do
#                 char="${arg:i:1}"
#                 is_separator=0

#                 # Check if the current character is a separator
#                 if [[ "$_FUZZY_SEPARATORS" == *"$char"* ]]; then
#                     is_separator=1
#                 fi

#                 if (( is_separator )); then
#                     # End of a part (or consecutive separators)
#                     if [[ -n "$current_part" ]]; then
#                         # Process the completed part: Check for '..' exception
#                         if [[ "$current_part" == ".." ]]; then
#                             fuzzy_single_arg+=".."
#                         else
#                             fuzzy_single_arg+="*${current_part}*"
#                         fi
#                         current_part="" # Reset for the next part
#                     fi
#                     # Append the separator itself
#                     fuzzy_single_arg+="$char"
#                 else
#                     # Character is part of a word segment
#                     current_part+="$char"
#                 fi
#             done # End character loop

#             # Append any remaining part after the loop finishes
#             if [[ -n "$current_part" ]]; then
#                  # Process the final part: Check for '..' exception
#                  if [[ "$current_part" == ".." ]]; then
#                      fuzzy_single_arg+=".."
#                  else
#                      fuzzy_single_arg+="*${current_part}*"
#                  fi
#             fi
#         fi
#         # --- END INLINED PURE BASH FUZZY LOGIC ---

#         # --- Append Result ---
#         # Note: fuzzy_single_arg will be empty if arg was empty
#         if [[ -n "$fuzzy_single_arg" ]]; then
#              fuzzy_args_final+=" $fuzzy_single_arg"
#         # Fallback not strictly needed as empty arg yields empty result
#         # But keep if desired for arguments containing *only* separators
#         elif [[ -n "$arg" ]]; then
#              fuzzy_args_final+=" $arg"
#         fi
#     done

#     IFS="$original_ifs" # Restore original IFS

#     # --- Update Readline ---
#     fuzzy_args_final="${fuzzy_args_final# }"
#     if [[ -n "$fuzzy_args_final" ]]; then
#         READLINE_LINE="$cmd $fuzzy_args_final"
#         READLINE_POINT=${#READLINE_LINE}
#     fi
# }
# bind -x '"\C-@\C-@": __make_fuzzy'
# }}}
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
export ZSHROOT="$HOME/zsh/usr"
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$ZSHROOT/share/zsh"
export ZSH_COMPDUMP="$ZDOTDIR/.zcompdump"

export ZSH_CONFIG_DIR="$ZDOTDIR"
export ZSH_CACHE_DIR="$ZDOTDIR/cache"
export ZSH_DATA_DIR="$ZDOTDIR/data"

# Optional for compiled modules
export LD_LIBRARY_PATH="$ZSHROOT/lib:$LD_LIBRARY_PATH"
export MODULE_PATH="$HOME/zsh/usr/lib/zsh/5.9/zsh"


