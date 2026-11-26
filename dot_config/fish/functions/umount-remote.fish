function umount-remote
    set -l short (string split -f1 @ -- $argv[1])
    set -l mnt $HOME/remote-$short
    fusermount3 -u $mnt 2>/dev/null
    and rmdir $mnt 2>/dev/null
end