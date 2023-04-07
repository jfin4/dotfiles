if status is-login

    set -gx PATH $HOME/scripts $PATH
    set -gx TERM xterm-256color

    sudo sh -c 'echo XHC0 > /proc/acpi/wakeup'
    sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'

    # if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    #     exec startx -- -keeptty
    # end

    if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
      exec Hyprland
    end

end

if status is-interactive

    fish_config theme choose None
    set -g fish_autosuggestion_enabled 0
    set -U fish_greeting

    abbr --add R        'start-r'
    abbr --add alarm    'set-alarm'
    abbr --add arc      'vim ~/.config/awesome/rc.lua'
    abbr --add bak      'backup-file'
    abbr --add bt       'manage-bluetooth'
    abbr --add crc      'vim ~/.cwmrc; pkill -HUP cwm'
    abbr --add default  'set-screen-layout default'
    abbr --add deorphan 'sudo pacman -Qtdq | sudo pacman -Rns -'
    abbr --add dot      'git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
    abbr --add dott     'sync-dot-repo'
    abbr --add dual     'set-screen-layout dual'
    abbr --add external 'set-screen-layout external'
    abbr --add fd       'wrap-find'
    abbr --add ff       'fuzzy-find-file'
    abbr --add focus    'play-focus-playlist'
    abbr --add frc      'vim ~/.config/fish/config.fish; source ~/.config/fish/config.fish'
    abbr --add gitt     'sync-repo'
    abbr --add gittt    'sync-all-repos'
    abbr --add install  'sudo pacman -S'
    abbr --add ji       'pandoc --template ~/.pandoc/johninman.dev --metadata title="John Inman" -o index.html'
    abbr --add jot      'take-notes'
    abbr --add kb       'get-key-bindings'
    abbr --add la       'ls -AlhF'
    abbr --add ll       'ls -lhF'
    abbr --add lynx     "lynx -cfg=$HOME/.lynx/lynx.cfg -lss=$HOME/.lynx/lynx.lss"
    abbr --add mam      'rtorrent -n -o import=~/.rtorrent-mam.rc'
    abbr --add mcam     'sudo mount /dev/disk/by-label/camera /mnt/camera/'
    abbr --add mobile   'connect-mobile'
    abbr --add mphone   'ifuse /mnt/phone'
    abbr --add mpv      'mpv --save-position-on-quit'
    abbr --add mrpi     'sshfs rpi:/ /mnt/rpi/'
    abbr --add mthumb   'sudo mount /dev/disk/by-label/thumb /mnt/thumb/'
    abbr --add mutt     'cd ~/downloads/ && mutt && cd'
    abbr --add mv       'mv --no-clobber'
    abbr --add mvv      'rename-files'
    abbr --add off      'turn-off-screen'
    abbr --add p        'pwd'
    abbr --add pad      'toggle-numpad'
    abbr --add reboot   'sudo reboot'
    abbr --add remove   'sudo pacman -R'
    abbr --add search   'sudo pacman -Ss'
    abbr --add shutdown 'sudo halt -p'
    abbr --add sshr     'ssh root@192.168.1.1'
    abbr --add t        'date "+%l:%M" | tr -d " "'
    abbr --add tm       'toggle-mod-key'
    abbr --add tmux     'tmux attach || tmux'
    abbr --add tp       'move-to-trash'
    abbr --add trc      'vim ~/.tmux.conf; tmux source-file ~/.tmux.conf'
    abbr --add ubak     'restore-file'
    abbr --add ucam     'sudo umount /mnt/camera/'
    abbr --add update   'sudo pacman -Syu'
    abbr --add uphone   'fusermount -u /mnt/phone'
    abbr --add urpi     'sudo umount /mnt/rpi/'
    abbr --add uthumb   'sudo umount /mnt/thumb/'
    abbr --add vpn      'set-vpn'
    abbr --add webcam   'start-webcam'
    abbr --add wifi     'connect-wifi'
    abbr --add ydl      'download-playlist'

    function pdf 
        zathura $argv & disown
    end

end
