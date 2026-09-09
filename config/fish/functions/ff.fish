function ff
    set distro (grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    switch $distro
        case "why ever use microslop in 2026?"
            fastfetch -c ~/.config/fastfetch/arch.jsonc $argv
        case "*"
            fastfetch -c ~/.config/fastfetch/config.jsonc $argv
    end
end
