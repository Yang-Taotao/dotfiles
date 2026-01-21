# fish greetings to empty
set -g fish_greeting ""

# env
if test -f ~/.fish_profile
    source ~/.fish_profile
end

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        ser -p PATH ~/.local/bin
    end
end

# module init
starship init fish | source
zoxide init fish | source
fzf --fish | source
thefuck --alias | source

# fetch
fastfetch

# ssh management
keychain --quiet --eval tyang@nightfall | source

# alias
## allegro 
alias mount-miscanti 'mkdir -p ~/remote-miscanti && sshfs -o follow-symlinks tyang@miscanti:/almastorage/allegro/home/tyang ~/remote-miscanti'
alias umount-miscanti 'fusermount3 -u ~/remote-miscanti 2>/dev/null && rmdir ~/remote-miscanti 2>/dev/null'
## eza - ls replace
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

# func
## yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ cwd != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f == "$tmp"
end
