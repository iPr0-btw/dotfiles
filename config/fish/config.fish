if status is-interactive

    export EDITOR=nvim
    export CONFIG=.config
    export EFI=/boot/EFI/BOOT/BOOTX64.EFI
    export LC_ALL=en_GB.UTF-8

    #set -U fish_user_paths $fish_user_paths ~/.local/bin

    function fish_prompt
        echo -n (prompt_pwd)' '
    end

    function fastfetch1
        fastfetch -c all
    end

    function fastfetch-apple
        fastfetch -l apple --pipe -c all
    end

    function bruh
        cmatrix -C cyan -u 2
    end

    function bios
        sudo systemctl reboot --firmware-setup
    end

    function linutil
        sudo curl -fsSL https://christitus.com/linux | bash
    end

    function arch-backup
        sudo rsync -aAXv --delete --exclude=/dev/ --exclude=/proc/ --exclude=/sys/ --exclude=/tmp/ --exclude=/run/ --exclude=/mnt/ --exclude=/media/ --exclude="swapfile" --exclude="lost+found" --exclude=/home/ --exclude=".cache" --exclude="Downloads" --exclude=".VirtualBoxVMs" --exclude=".ecryptfs" / /mnt/arch
    end

    function fedora-backup
        sudo rsync -aAXv --delete --exclude=/dev/ --exclude=/proc/ --exclude=/sys/ --exclude=/tmp/ --exclude=/run/ --exclude=/mnt/ --exclude=/media/ --exclude="swapfile" --exclude="lost+found" --exclude=/home/ --exclude=".cache" --exclude="Downloads" --exclude=".VirtualBoxVMs" --exclude=".ecryptfs" / /mnt/fedora
    end
    function debian-backup
        sudo rsync -aAXv --delete --exclude=/dev/ --exclude=/proc/ --exclude=/sys/ --exclude=/tmp/ --exclude=/run/ --exclude=/mnt/ --exclude=/media/ --exclude="swapfile" --exclude="lost+found" --exclude=/home/ --exclude=".cache" --exclude="Downloads" --exclude=".VirtualBoxVMs" --exclude=".ecryptfs" / /mnt/debian
    end
    function home-backup
        sudo rsync -aAXv --delete ~ /mnt/global-home-folder
    end

    function v
        nvim
    end

    # Commands to run in interactive sessions can go here
    set fish_greeting ""
end
export TERMINAL=kitty
export WLR_DRM_DEVICES=/dev/dri/card1
export MOZ_ENABLE_WAYLAND 1
thefuck --alias --enable-experimental-instant-mode | source
