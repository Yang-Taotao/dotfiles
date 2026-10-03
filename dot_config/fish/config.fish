# fish greetings to empty
# set -g fish_greeting ""

# env
if test -f ~/.fish_profile
    source ~/.fish_profile
end

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# interactive mode settings
if status --is-interactive
    # modules init
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source
    thefuck --alias | source
    # ssh keychain
    keychain --quiet --quick --eval $USER@$hostname | source

    # fetch
    function fish_greeting
        # set systemd flag for one fetch per login session
        if not systemctl --user show-environment | grep -q "FASTFETCH_RAN=1"
            systemctl --user set-environment FASTFETCH_RAN=1
            sleep 0.1
            fastfetch
        end
    end

    ## yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f "$tmp"
    end

    ## rm nuke
    function nuke
        # exception
        if test (count $argv) -eq 0
            set_color yellow
            echo "NUKE ERROR: Targets required. Aborted."
            set_color normal
            return 1
        end

        # set counter
        set -l targets_lists (command find $argv 2>/dev/null)
        set -l targets_count (count $targets_lists)

        # exception if no file exists
        if test $targets_count -eq 0
            set_color yellow
            echo "NUKE ERROR: Invalid targets. Aborted."
            return 1
        end

        # warning
        set_color red --bold
        echo "NUKE WARNING  : Requesting base 'rm -rf' binary."
        # file list
        echo "NUKE TARGETS  : Targeting $targets_count objectives: "

        set_color yellow
        for target in $argv
            echo "              - $target"
        end

        # confirmation
        set -l nuke_prompt (set_color red --bold)"NUKE AUTHORIZE: Requesting key: "
        echo ""
        read -s -l -P "$nuke_prompt" NUKE_AUTH_USR

        # load secret
        set -l NUKE_AUTH_SYS (secret-tool lookup id NUKE_AUTH)

        if test "$NUKE_AUTH_USR" = $NUKE_AUTH_SYS
            set_color green
            /usr/bin/rm -rf $argv
            echo "NUKE SPLASH   : Good effect on targets, $targets_count destroyed."
            set_color normal
        else
            set_color green
            echo "NUKE ABORTED  : Targets reset to null."
            set_color normal
        end
    end

    # alias
    ## allegro
    alias mount-miscanti \
        'mkdir -p ~/remote-miscanti && \
        sshfs -o follow_symlinks $USER@miscanti:/almastorage/allegro/home/$USER \
        ~/remote-miscanti'
    alias umount-miscanti \
        'fusermount3 -u ~/remote-miscanti 2>/dev/null && \
        rmdir ~/remote-miscanti 2>/dev/null'
    ## eza
    alias ls 'eza -al --color=always --group-directories-first --icons'
    alias la 'eza -a --color=always --group-directories-first --icons'
    alias ll 'eza -l --color=always --group-directories-first --icons'
    alias lt 'eza -aT --color=always --group-directories-first --icons'
    ## cd
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'
    ## common
    alias wget 'wget -c'
    alias grep 'grep --color=auto'
    alias fgrep 'fgrep --color=auto'
    alias egrep 'egrep --color=auto'
    ## tar
    alias tarthis 'tar -acf'
    alias untarthis 'tar -zxvf'
    ## additional
    alias hw 'hwinfo --short'
    alias big "expac -H M '%m\t%n' | sort -h | nl"
    alias rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    alias update 'sudo pacman -Syu'
    alias clean 'sudo pacman -Rns (pacman -Qtdq)'
    alias jctl 'journalctl -p 3 -xb'
    ## gdm failsafe
    alias fixgdm 'sudo systemctl restart gdm'
    ## rm failsafe
    alias rm 'rm -i'

end

# conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH $HOME/miniforge3/bin $PATH
    end
end
# <<< conda initialize <<<
