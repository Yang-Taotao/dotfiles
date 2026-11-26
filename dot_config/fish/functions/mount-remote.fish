function mount-remote
    set -l host $argv[1]
    set -l short (string split -f1 @ -- $host)
    set -l mnt $HOME/remote-$short

    mkdir -p $mnt
    if set -q argv[2]
        sshfs -o follow_symlinks -o reconnect $host:$argv[2] $mnt
    else
        sshfs -o follow_symlinks -o reconnect $host: $mnt
    end
    and echo "mounted $host → $mnt"
end