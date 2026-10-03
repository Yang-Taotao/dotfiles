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
