function zen --wraps='sudo efibootmgr -n 4 && reboot' --description 'alias zen=sudo efibootmgr -n 4 && reboot'
    sudo efibootmgr -n 4 && reboot $argv
end
