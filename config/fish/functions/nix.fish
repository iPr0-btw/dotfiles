function nix --wraps='sudo efibootmgr -n B; reboot' --description 'alias nix=sudo efibootmgr -n B; reboot'
    sudo efibootmgr -n B; reboot $argv
end
