# rm safe
function rm
    for arg in $argv
        if test "$arg" = /; or test "$arg" = "/*"
            set_color red --bold
            echo "WARNING: YOU SHALL NOT NUKE THE ROOT DIRECTORY!!!"
            set_color normal
            return 1
        end
    end
    command rm -i $argv
end
