function fish_greeting
    # set systemd flag for one fetch per login session
    if not systemctl --user show-environment | grep -q "FASTFETCH_RAN=1"
        systemctl --user set-environment FASTFETCH_RAN=1
        sleep 0.1
        fastfetch
    end
end
