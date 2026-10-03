# rm nuke
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
