fish_config theme choose None
set -g fish_autosuggestion_enabled 1
set -U fish_greeting

# nnn
set -gx EDITOR /usr/bin/vim
set -gx NNN_BMS 'b:/home/jfin;h:/h;d:/c/users/jinman/downloads;p:/r/rb3/shared/basin planning;r:/r/rb3/shared;u:/c/users/jinman'
set -gx NO_COLOR 1

abbr --add R                '\R --no-save --quiet'
abbr --add bak              'back-up-file'
abbr --add cal              'cal -y'
abbr --add --position anywhere --set-cursor up/ '/c/Users/JInman/%'
abbr --add cp               'cp --recursive --no-clobber'
abbr --add dash             'ENV=~/.shinit dash'
abbr --add dot              'git-dot'
abbr --add dott             'push-dot-repo'
abbr --add go               'open-link'
abbr --add install          'pacman -S'
abbr --add jot              'take-notes'
abbr --add kb               'show-key-bindings'
abbr --add la               'ls -AlhF'
abbr --add ll               'ls -lhF'
abbr --add lock             'cmd //c Rundll32.exe user32.dll,LockWorkStation'
abbr --add mdd              'convert-markdown-to-word'
abbr --add mv               'mv --no-clobber'
abbr --add mvv              'rename-files'
abbr --add nnn              'nnn -A'
abbr --add path             'copy-path'
abbr --add pink             'play-tracks -q ~/music/sounds/pink.mp3'
abbr --add play             'play-tracks'
abbr --add prod             'Rscript ~/scripts/get-productivity.r $(cygpath -w $USERPROFILE/msys/home/jfin/hours)'
abbr --add log             'take-notes "#proj"'
abbr --add pull             'pull-repo'
abbr --add push             'push-repo'
abbr --add pw               'get-password'
abbr --add remove           'pacman -Rns'
abbr --add tp               'move-to-trash'
abbr --add search           'pacman -Ss'
abbr --add summary          'Rscript ~/scripts/get-summary.r $(cygpath -w $USERPROFILE/msys/home/jfin/hours)'
abbr --add sync             'sync-all-repos'
abbr --add todo             'take-notes \#todo'
abbr --add trc              'vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
abbr --add update           'pacman -Syu'
abbr --add frc              'vim ~/.config/fish/config.fish; source ~/.config/fish/config.fish'
abbr --add gitt             '~/scripts/push-repo'